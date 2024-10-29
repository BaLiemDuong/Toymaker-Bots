classdef Operate < handle
    properties
    end
    methods (Static)
        function mov(r, T, q0)
            steps = 100;
            qNow = r.model.getpos();
            
            % Modify `T` to ensure end effector is above 0.5 on the Z-axis
            T(3,4) = max(T(3,4), 0.6);  % Set Z position of target to be at least 0.6

            % Calculate the joint angles to reach this position
            qTarget = r.model.ikcon(T, q0);
            qMatrix = jtraj(qNow, qTarget, steps);

            for i = 1:size(qMatrix, 1)
                q = qMatrix(i, :);
                r.model.animate(q);

                % Retrieve the current transformation matrix of Hanscute base
                baseTransform = r.model.fkine(q);

                if size(baseTransform, 1) == 4 && size(baseTransform, 2) == 4
                    % Apply translational offset for wheel positions relative to the Hanscute base
                    wheelPos1 = baseTransform * [0.1; -0.1; 0; 1];  % Left wheel offset
                    wheelPos2 = baseTransform * [0.1; 0.1; 0; 1];   % Right wheel offset

                    % Update the wheel positions using Environment.wheels function
                    Environment.wheels(wheelPos1(1:3)');  % Position left wheel
                    Environment.wheels(wheelPos2(1:3)');  % Position right wheel
                else
                    warning('baseTransform is not a 4x4 matrix. Skipping wheel update.');
                end

                pause(0.01);
            end
        end

        function qtrajec = CreateTraj(robot, brickPosition, jointGuess)
            steps = 100;
            qNow = robot.model.getpos();
            T = transl(brickPosition);
            % Joint states that pick up the brick
            qMove = robot.model.ikcon(T, jointGuess);  
            qtrajec = jtraj(qNow, qMove, steps);
        end

        function MoveFinger2(r, q, finger1, finger2, i)
            q_f1_traj = jtraj(finger1.model.getpos(), 0, 100);
            q_f2_traj = jtraj(finger2.model.getpos(), 0, 100);
            base = r.model.fkineUTS(q);
            
            % Update the base of the gripper and move fingers simultaneously
            finger1.model.base = base;
            finger1.model.animate(q_f1_traj(i, :));
            finger2.model.base = base;
            finger2.model.animate(q_f2_traj(i, :));
        end

        function Move2Part(r, qTraj, finger1, finger2)
            for i = 1:size(qTraj, 1)
                q = qTraj(i, :);
                r.model.animate(q);
                Operate.MoveFinger2(r, q, finger1, finger2, i);
                pause(0.01);
            end
        end

        function PlotPose(self, qArray, freq, f1, f2, bricknum)
            [f, v, data] = plyread('car_base.ply', 'tri');
            vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
            BrickVertexCount = size(v, 1);
            BrickMesh_h = trisurf(f, v(:,1)+bricknum(1,1), v(:,2)+bricknum(1,2), v(:,3)+bricknum(1,3), ...
                'FaceVertexCData', vertexColours, 'EdgeColor', 'none', 'EdgeLighting', 'none');

            for i = 1:size(qArray, 1)
                brick = self.model.fkineUTS(qArray(i, :));
                BrickPose = brick * transl(0, 0, 0.1);

                UpdatedPoints = [BrickPose * [v, ones(BrickVertexCount, 1)]']';
                BrickMesh_h.Vertices = UpdatedPoints(:, 1:3);

                self.model.animate(qArray(i, :));

                q_f1 = f1.model.getpos();
                q_f2 = f2.model.getpos();
                q_f1_end = deg2rad([10, 0]);
                q_f2_end = deg2rad([10, 0]);
                q_f1_traj = jtraj(q_f1, q_f1_end, 100);
                q_f2_traj = jtraj(q_f2, q_f2_end, 100);

                base = self.model.fkineUTS(qArray(i, :));
                f1.model.base = base * trotx(pi/2);
                f1.model.animate(q_f1_traj(i, :));
                f2.model.base = base * troty(pi) * trotx(-pi/2);
                f2.model.animate(q_f2_traj(i, :));

                pause(0.0005);

                if mod(i, freq) == 0
                    currPosition = transl(self.model.fkine(qArray(i, :)).T)';
                    message = strcat('DEBUG: ', ' Current position = ', num2str(currPosition));
                    disp(message);
                end
            end
        end
    end
end
