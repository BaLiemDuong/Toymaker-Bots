classdef Operate < handle
    properties
    end
    methods (Static)
        function qMatrix = traj(r,T,q0)
            steps = 100;
            qNow = r.model.getpos();
            qTarget = r.model.ikcon(T,q0);
            qMatrix = jtraj(qNow,qTarget,steps);
        end
        function mov(r,qMatrix,finger1,finger2)
            for i = 1:size(qMatrix,1)
                q = qMatrix(i,:);
                r.model.animate(q);
                Operate.MoveFinger(r,q,finger1,finger2,i);
                pause(0.01)
            end
        end

        function MoveFinger(r,q,finger1,finger2,i)

            % Define initial and final positions for closing movement
            q_f1_initial = finger1.model.getpos();
            q_f1_final = q_f1_initial; % Move finger1 towards center
            
            q_f2_initial = finger2.model.getpos();
            q_f2_final = q_f2_initial; % Move finger2 towards center
        
            % Generate trajectories for fingers
            q_f1_traj = jtraj(q_f1_initial, q_f1_final, 100);
            q_f2_traj = jtraj(q_f2_initial, q_f2_final, 100);
            base = r.model.fkineUTS(q);
            
            %Update the base of the gripper and also move the finger
            %simutaneously
            finger1.model.base=base*transl(-0.016,-0.03,0.1);

            finger1.model.animate(q_f1_traj(i,:));

            finger2.model.base=base*transl(-0.016,0.03,0.1);

            finger2.model.animate(q_f2_traj(i,:));

        end

        function PlotPose(name,self,qArray,f1,f2,bricknum)

            %Read the ply file in faces, vertices, and color it
            [f,v,data] = plyread(name,'tri');
            vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
            BrickVertexCount = size(v,1);
            BrickMesh_h = trisurf(f,v(:,1)+bricknum(1,1),v(:,2)+bricknum(1,2), v(:,3)+bricknum(1,3) ...
                ,'FaceVertexCData',vertexColours,'EdgeColor','none','EdgeLighting','none');

            for i=1:size(qArray,1)

                % Take the forward kinematic for the brick
                brick = self.model.fkineUTS(qArray(i,:));

                %Create a BrickPose after it run through a row of qArray, BrickPose is the
                %4x4 matrix, transl(0,0,0.1) is move the brick down 0.1 in the Z direction
                %to make it look like it is graspped by the gripper
                BrickPose = brick*transl(0,0,0.1) ;

                %MOVE THE BRICK. Update the point then multiply it to the vertices
                UpdatedPoints = [BrickPose * [v,ones(BrickVertexCount,1)]']';

                %The vertices are all the rows and 1 to 3 columns of the UpdatedPoints
                BrickMesh_h.Vertices = UpdatedPoints(:,1:3);

                %Animate the robot arm
                self.model.animate(qArray(i,:));

                %Create a set of joint states to make the finger open from 0 degree to 20

                q_f1_traj = jtraj(f1.model.getpos(),0,100);
                q_f2_traj = jtraj(f2.model.getpos(),0,100);


                %Transform the gripper by update the base and OPEN THE FINGER SIMUTANEOUSLY
                base = self.model.fkineUTS(qArray(i,:));
                f1.model.base = base;
                f1.model.animate(q_f1_traj(i,:))
                f2.model.base = base;
                f2.model.animate(q_f2_traj(i,:))

                pause(0.0005);
            end

        end
    end
end
