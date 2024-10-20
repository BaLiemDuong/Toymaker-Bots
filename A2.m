clc;
clf;
hold on;

% Set figure size
axis ([-2 2 -2.5 1 -0.1 1.5]);
% Place Hans bot
r = HansCute(transl(-0.4,0,0.555));
% Take the base of end-effector 
base = r.model.fkineUTS(r.model.getpos());
%Call the 2 fingers and plot the calculated base 
finger1 = HansFinger(base*transl(-0.016,-0.03,0.08)*trotz(deg2rad(35)));
finger2 = HansFinger(base*transl(-0.016,0.03,0.08)*trotz(deg2rad(215)));
%% Position of objects
% Fence 1
x1 = 0;y1 = 1.3;z1 = 0;
% Fence 2
x2 = 0;y2 = 1.3;z2 = 0;
% Fence 3
x3 = 0;y3 = -1.3;z3 = 0;
% Fence 4
x4 = 0;y4 = -1.3;z4 = 0;
% Conveyer 1
x5 = -0.8;y5 = 0;z5 = 0;
% Conveyer 2
x6 = 0.9;y6 = 0;z6 = 0;
% Table
x7 = 0;y7 = 0;z7 = 0;
% E-stop
x8 = 0.4;y8 = -0.3;z8 = 0.5;
% Car body
x9 = 0.8;y9 = 0;z9 = 0.57;
% Car
x10 = -0.8;y10 = 0.1;z10 = 0.57;
% Car
x11 = -0.8;y11 = -0.1;z11 = 0.57;

% Place objects
Environment.floor();
Environment.fence1(x1,y1,z1);
Environment.fence2(x2,y2,z2);
Environment.fence3(x3,y3,z3);
Environment.fence4(x4,y4,z4);
Environment.conveyer1(x5,y5,z5);
Environment.conveyer2(x6,y6,z6);
Environment.table(x7,y7,z7);
Environment.button(x8,y8,z8);
Environment.car_base(x9,y9,z9);
Environment.car_body(x10,y10,z10);
Environment.wheels(x11,y11,z11);
daspect([1 1 1]);
% Add axis labels
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
%% Move and stuffs
qTraj = CreateTraj(r, [0.25,0.25,0.75], q0);
move(r, qTraj,finger1,finger2);

qTraj = CreateTraj(r, [-0.25, -0.25, 0.75], q0);
move(r, qTraj,finger1,finger2);
