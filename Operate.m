classdef Operate < handle
    properties
    end
    methods (Static)
        function qtrajec = CreateTraj(robot,brickPosition,jointGuess)
    steps = 100;
    qNow = robot.model.getpos();
    T = transl(brickPosition)*trotx(pi)*troty(0)*trotz(0);
    %Joint states that pick up the brick
    qMove = robot.model.ikcon(T);  
    qtrajec = jtraj(qNow,qMove,steps);
end

function move(r, qTraj,finger1,finger2)
    for i = 1:size(qTraj,1)
        q = qTraj(i,:);
        r.model.animate(q);
        MoveFinger(r,q,finger1,finger2,i);
        pause(0.01)
    end
end

function MoveFinger(r,q,finger1,finger2,i)

            q_f1 = finger1.model.getpos();
            q_f2 = finger2.model.getpos();
            q_f1_end = deg2rad([25 0]);
            q_f2_end = deg2rad([25 0]);
            q_f1_traj = jtraj(q_f1,q_f1_end,100);
            q_f2_traj = jtraj(q_f2,q_f2_end,100);
            base = r.model.fkineUTS(q);
            
            %Update the base of the gripper and also move the finger
            %simutaneously
            finger1.model.base=base*trotx(pi/2);

            finger1.model.animate(q_f1_traj(i,:));

            finger2.model.base=base*troty(pi)*trotx(-pi/2);

            finger2.model.animate(q_f2_traj(i,:));

        end

function MoveFinger2(r,q,finger1,finger2,i)

            % q_f1 = finger1.model.getpos();
            % q_f2 = finger2.model.getpos();
            % q_f1_end = deg2rad([25 0]);
            % q_f2_end = deg2rad([25 0]);
            % q_f1_traj = jtraj(q_f1,q_f1_end,100);
            % q_f2_traj = jtraj(q_f2,q_f2_end,100);
            q_f1_traj = transl(-pi/2,0,0);
            q_f2_traj = transl(pi/2,0,0);
            base = r.model.fkineUTS(q);
            
            %Update the base of the gripper and also move the finger
            %simutaneously
            finger1.model.base=base*trotx(pi/2);

            finger1.model.animate(q_f1_traj);%(i,:)

            finger2.model.base=base*troty(pi)*trotx(-pi/2);

            finger2.model.animate(q_f2_traj);%(i,:)

end
    end
end