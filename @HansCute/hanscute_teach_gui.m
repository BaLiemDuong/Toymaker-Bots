function hanscute_teach_gui()
    % Load the HansCute robot model
    run('HansCute.m');
    robot = HansCute; % Initialize the robot based on HansCute.m

    % Initialize the GUI figure
    fig = uifigure('Name', 'HansCute Robot Teach Interface', 'Position', [100, 100, 600, 600]);
    
    % Set up joint control sliders and labels
    for i = 1:7
        uilabel(fig, 'Position', [10, 550 - i * 50, 80, 30], 'Text', ['Joint ', num2str(i)]);
        jointSlider(i) = uislider(fig, 'Position', [100, 565 - i * 50, 120, 3], ...
                                  'Limits', [-pi, pi], 'ValueChangedFcn', @(sld, event) jointControl(i, sld.Value, robot));
    end

    % Cartesian Controls (X, Y, Z)
    uilabel(fig, 'Position', [300, 400, 80, 30], 'Text', 'X:');
    xEdit = uieditfield(fig, 'numeric', 'Position', [350, 400, 100, 30], 'ValueChangedFcn', @(edt, event) cartesianControl(robot, xEdit, yEdit, zEdit));
    
    uilabel(fig, 'Position', [300, 350, 80, 30], 'Text', 'Y:');
    yEdit = uieditfield(fig, 'numeric', 'Position', [350, 350, 100, 30], 'ValueChangedFcn', @(edt, event) cartesianControl(robot, xEdit, yEdit, zEdit));
    
    uilabel(fig, 'Position', [300, 300, 80, 30], 'Text', 'Z:');
    zEdit = uieditfield(fig, 'numeric', 'Position', [350, 300, 100, 30], 'ValueChangedFcn', @(edt, event) cartesianControl(robot, xEdit, yEdit, zEdit));
    
    % Enable keyboard arrow key control
    fig.KeyPressFcn = @(src, event) arrowKeyControl(event, robot, xEdit, yEdit, zEdit);
end

% Joint Movement Control Callback
function jointControl(joint_idx, angle, robot)
    q = robot.getpos();
    q(joint_idx) = angle;
    robot.plot(q); % Update robot pose in GUI
end

% Cartesian Control Callback
function cartesianControl(robot, xEdit, yEdit, zEdit)
    % Retrieve values from the Cartesian fields
    pos = [xEdit.Value, yEdit.Value, zEdit.Value];
    % Solve inverse kinematics for the given position
    q = robot.ikine(transl(pos), 'mask', [1 1 1 0 0 0]);
    robot.plot(q); % Update robot pose in GUI
end

% Arrow Key Control for Cartesian Movement
function arrowKeyControl(event, robot, xEdit, yEdit, zEdit)
    pos = [xEdit.Value, yEdit.Value, zEdit.Value]; % Current position
    
    switch event.Key
        case 'uparrow'
            pos(2) = pos(2) + 0.01; % Move Y up
        case 'downarrow'
            pos(2) = pos(2) - 0.01; % Move Y down
        case 'rightarrow'
            pos(1) = pos(1) + 0.01; % Move X right
        case 'leftarrow'
            pos(1) = pos(1) - 0.01; % Move X left
        case 'pageup'
            pos(3) = pos(3) + 0.01; % Move Z up
        case 'pagedown'
            pos(3) = pos(3) - 0.01; % Move Z down
    end
    
    % Update the position fields in the GUI
    xEdit.Value = pos(1);
    yEdit.Value = pos(2);
    zEdit.Value = pos(3);
    
    % Solve inverse kinematics for the new position using robot.model
    q = robot.model.ikine(transl(pos), 'mask', [1 1 1 0 0 0]);
    robot.model.plot(q); % Update robot pose in GUI
end

