clc;
clf;
hold on;

% Set figure size
axis ([-2 2 -2.5 1 -0.1 1.5]);
% Place Hans bot
r = HansCute(transl(-0.32,0,0.5));
% Place Toy bot
%b = ToyBot(transl(0.4,0,0.555));
% Take the base of end-effector 
base = r.model.fkineUTS(r.model.getpos());
%Call the 2 fingers and plot the calculated base 
finger1 = HansFinger(base*transl(-0.016,-0.03,0.08)*trotz(deg2rad(35)));
finger2 = HansFinger(base*transl(-0.016,0.03,0.08)*trotz(deg2rad(215)));
%% Position of objects
% Fence 1
pos1 = [0 1.3 0];
% Fence 2
pos2 = [0 1.3 0];
% Fence 3
pos3 = [0 -1.3 0];
% Fence 4
pos4 = [0 -1.3 0];
% Conveyer 1
pos5 = [-0.55 0 0];
% Conveyer 2
pos6 = [0.65 0 0];
% Table
pos7 = [0 0 0];
% E-stop
pos8 = [0.25 -0.15 0.5];
% Car base
pos9 = [0.55 -0.1 0.57];
% Car body
pos10 = [0.55 0.1 0.57];
% Car wheels 1
pos11 = [-0.55 -0.1 0.57];
% Car wheels 2
pos12 = [-0.55 0.1 0.57];

%% Place objects
Environment.floor();
Environment.fence1(pos1);
Environment.fence2(pos2);
Environment.fence3(pos3);
Environment.fence4(pos4);
Environment.conveyer1(pos5);
Environment.conveyer2(pos6);
Environment.table(pos7);
Environment.button(pos8);
Environment.car_base(pos9);
Environment.car_body(pos10);
Environment.wheels(pos11);
Environment.wheels(pos12);
daspect([1 1 1]);
% Add axis labels
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
%% Move and stuffs
% car = [-0.8 0.1 0.7];
% guess = [-90 0 0 0 0 90 0];
% carend = [0 0 0.7];
% armend = [90 0 0 0 0 90 0];
% qtraj = Operate.CreateTraj(r,car,guess);
% 
% Operate.Move2Part(r,qtraj,finger1,finger2);
% 
% qTraj = Operate.CreateTraj(r, carend, armend);
%%
% Hans first movement
q0 = deg2rad([45 45 45 0 0 90 0]);
T = transl(-0.55 ,-0.1, 0.6)*troty(-pi);
Operate.mov(r,T,q0);
% Hans first movement
q0 = deg2rad([-45 -45 -45 0 0 90 0]);
T = transl(-0.2 ,0.1, 0.51)*troty(-pi);
Operate.mov(r,T,q0);
% Hans third movement
q0 = deg2rad([45 45 45 0 0 90 0]);
T = transl(-0.55 ,0.1, 0.6)*troty(-pi);
Operate.mov(r,T,q0);
% Hans fourth movement
q0 = deg2rad([-45 -45 -45 0 0 90 0]);
T = transl(-0.2, -0.1, 0.51)*troty(-pi);
Operate.mov(r,T,q0);
% % Toybot first movement
% q0 = deg2rad([45 45 45 0 0 90 0]);
% T = transl(0.55 ,-0.1, 0.57)*troty(-pi);
% Operate.mov(T,q0);
% % Toybot second movement
% q0 = deg2rad([45 45 45 0 0 90 0]);
% T = transl(0.55 ,0.1, 0.57)*troty(-pi);
% Operate.mov(T,q0);
