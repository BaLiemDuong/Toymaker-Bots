clc;
clf;
hold on;

axis ([-1 1 -1 1 -0.1 1.3]);
r = HansCute(transl(0,0,0.555));

% Take the base of end-effector 
% qNow = r.model.getpos();
% base = r.model.fkineUTS(qNow);
base = r.model.fkineUTS(r.model.getpos());
%Call the gripper with 2 fingers and plot the calculated base 
finger1 = HansFinger(base*transl(-0.016,-0.03,0.08)*trotz(deg2rad(35)));%(base*transl(0, 0.02, 0));%(base*trotx(pi/2));
finger2 = HansFinger(base*transl(-0.016,0.03,0.08)*trotz(deg2rad(215)));%*transl(0, -0.02, 0)*trotz(pi)); %base*troty(pi)*trotx(-pi/2)

%PlaceObject('tableBlue1x1x0.5m.ply', [0,0,0]);
%Environment.place_fence(0.5,0.5,0,pi/2);
%Environment.place_stationary_objects([0,0,0],[0.3,0.3,0.55],[-0.5,0.5,0],[0.5,-0.5,0]);
%Environment.place_object('carbase.ply',0.2,0.2,0.6,0,0,0);

% q0 = [0,0,0,0,0,0];
% q1 = [-0.016,-0.03,0.08];
% q2 = [-0.8,-0.8,0.08];
% tr = jtraj(q1,q2,50);
% finger1.model.animate(tr(50,:));
%% 

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

hold off;
qTraj = CreateTraj(r, [0.25,0.25,0.75], q0);
move(r, qTraj,finger1,finger2);

qTraj = CreateTraj(r, [-0.25, -0.25, 0.75], q0);
move(r, qTraj,finger1,finger2);