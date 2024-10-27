classdef Operate < handle
    properties
    end
    methods (Static)
        function mov(r,T,q0)
            steps = 100;
            qNow = r.model.getpos();
            qTarget = r.model.ikcon(T,q0);
            qMatrix = jtraj(qNow,qTarget,steps);
            
            for i = 1:size(qMatrix,1)
                q = qMatrix(i,:);
                r.model.animate(q);
                pause(0.01)
            end
        end

        
        
        
        
        
        
        
        
        
        
        
        function qtrajec = CreateTraj(robot,brickPosition,jointGuess)
            steps = 100;
            qNow = robot.model.getpos();
            T = transl(brickPosition);
            %Joint states that pick up the brick
            qMove = robot.model.ikcon(T,jointGuess);  
            qtrajec = jtraj(qNow,qMove,steps);
        end
        
function MoveFinger2(r,q,finger1,finger2,i)

            % q_f1 = finger1.model.getpos();
            % q_f2 = finger2.model.getpos();
            % q_f1_end = deg2rad([25 0]);
            % q_f2_end = deg2rad([25 0]);
            % q_f1_traj = jtraj(q_f1,q_f1_end,100);
            % q_f2_traj = jtraj(q_f2,q_f2_end,100);

            % q_f1_traj = transl(-pi/2,0,0);
            % q_f2_traj = transl(pi/2,0,0);

            q_f1_traj = jtraj(finger1.model.getpos(),0,100);
            q_f2_traj = jtraj(finger2.model.getpos(),0,100);
            base = r.model.fkineUTS(q);
            
            %Update the base of the gripper and also move the finger
            %simutaneously
            finger1.model.base=base;

            finger1.model.animate(q_f1_traj(i,:));

            finger2.model.base=base;

            finger2.model.animate(q_f2_traj(i,:));

        end

        function Move2Part(r, qTraj,finger1,finger2)
            for i = 1:size(qTraj,1)
                q = qTraj(i,:);
                r.model.animate(q);
                Operate.MoveFinger2(r,q,finger1,finger2,i);
                pause(0.01)
            end
        end
        function PlotPose(self,qArray,freq,f1,f2,bricknum)



            % figure(1);
            % 
            % %Create a log file for debug
            % logFileName = strcat('logLinearUR3',self.model.name,'.log');
            % L = log4matlab(logFileName);
            % disp(strcat("Logging on file: ",logFileName));
            % 
            % num = 1;
            %Read the ply file in faces, vertices, and color it
            [f,v,data] = plyread('car_base.ply','tri');
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

                q_f1 = f1.model.getpos();
                q_f2 = f2.model.getpos();
                q_f1_end = deg2rad([10 0]);
                q_f2_end = deg2rad([10 0]);
                q_f1_traj = jtraj(q_f1,q_f1_end,100);
                q_f2_traj = jtraj(q_f2,q_f2_end,100);


                %Transform the gripper by update the base and OPEN THE FINGER SIMUTANEOUSLY
                base = self.model.fkineUTS(qArray(i,:));
                f1.model.base = base*trotx(pi/2);
                f1.model.animate(q_f1_traj(i,:))
                f2.model.base = base*troty(pi)*trotx(-pi/2);
                f2.model.animate(q_f2_traj(i,:))

                pause(0.0005);

                %Display the current position of the end-effector every 'freq' times
                if mod(num,freq) == 0
                    currPosition = transl(self.model.fkine(qArray(i,:)).T)';
                    message = strcat('DEBUG: ',' Current position = ',num2str(currPosition));
                    L.mlog = {L.DEBUG,'LinearUR3',message};
                    disp(message);
                end
                num = num + 1;

            end

        end
    end
end
