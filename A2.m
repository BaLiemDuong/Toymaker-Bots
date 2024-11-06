clc;
clf;
hold on;

% Set figure size
axis ([-2 2 -2.5 1 -0.1 1.5]);
% Place Hans bot
r = HansCute(transl(-0.32,0,0.5));
% Place Toy bot
b = ToyBot(transl(0.3,0,0.555));
% Take the base of end-effector 
base = r.model.fkineUTS(r.model.getpos());
%Call the 2 fingers and plot the calculated base 
finger1 = HansFinger(base*transl(-0.016,-0.03,0.1)*trotz(deg2rad(30)));
finger2 = HansFinger(base*transl(-0.016,0.03,0.1)*trotz(deg2rad(210)));
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
p1 = Environment.car_base(pos9);
p2 = Environment.car_body(pos10);
p3 = Environment.wheels(pos11);
p4 = Environment.wheels(pos12);
daspect([1 1 1]);
% Add axis labels
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
%%
% Hans first movement
q0 = deg2rad([45 0 -45 0 0 0 0]);
T = transl(-0.55 ,-0.1, 0.7)*troty(-pi);
qMatrix = Operate.traj(r,T,q0);
Operate.mov(r,qMatrix,finger1,finger2);
% Delete car part
try delete(p3); 
catch ME
end
% Grab part and move
q0 = deg2rad([90 0 0 0 0 0 0]);
T = transl(0, -0.05, 0.6)*troty(-pi);
qMatrix = Operate.traj(r,T,q0);
Operate.PlotPose('wheels_axial.ply',r,qMatrix,finger1,finger2,pos11);

% Hans second movement
q0 = deg2rad([45 0 -45 0 0 0 0]);
T = transl(-0.55 ,0.1, 0.7)*troty(-pi);
qMatrix = Operate.traj(r,T,q0);
Operate.mov(r,qMatrix,finger1,finger2);
% Delete car part
try delete(p4); 
catch ME
end
% Grab part and move
q0 = deg2rad([90 0 0 0 0 0 0]);
T = transl(0, 0.05, 0.6)*troty(-pi);
qMatrix = Operate.traj(r,T,q0);
Operate.PlotPose('wheels_axial.ply',r,qMatrix,finger1,finger2,pos12);

% Hans third movement
q0 = deg2rad([45 0 0 0 0 0 0]);
T = transl(-0.32,0,1);
qMatrix = Operate.traj(r,T,q0);
Operate.mov(r,qMatrix,finger1,finger2);

% Toybot first movement
q0 = deg2rad([90 0 0 0 0 0 0]);
T = transl(0.55 ,-0.1, 0.7)*troty(-pi);
qMatrix = Operate.traj(b,T,q0);
Operate.mov(b,qMatrix,finger1,finger2);
% Delete car part
try delete(p1); 
catch ME
end
% Grab part and move
q0 = deg2rad([90 0 -45 0 0 0 0]);
T = transl(-0.2, 0, 0.65)*troty(-pi);
qMatrix = Operate.traj(b,T,q0);
Operate.PlotPose('car_base.ply',b,qMatrix,finger1,finger2,pos10);
