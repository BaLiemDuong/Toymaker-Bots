classdef HansFinger < RobotBaseClass

    properties(Access = public)   
        plyFileNameStem = 'HansFinger';
    end

    methods (Access = public) 
        %% Define robot Function  
        function self = HansFinger(baseTr)
			self.CreateModel();
            if nargin < 1			
				baseTr = transl(0,0,0);				
            end
            self.model.base =  baseTr  ;%self.model.base.T * 
            
            self.PlotAndColourRobot();        
        end

        %% Create the robot model
        function CreateModel(self)       
            % link(1) = Link('d',0,'a',0.047,'alpha',0,'qlim',deg2rad([-10 25]),'offset',deg2rad(30)); 
            % link(2) = Link('d',0,'a',0.04,'alpha',0,'qlim',deg2rad([0 0.01]),'offset',deg2rad(30));

            % link(1) = Link('theta', 0, 'a', 0, 'alpha', 0, 'qlim', [0.1 0.5], 'offset', deg2rad(60), 'prismatic', 1);
            link(1) = Link([0     0       0       [0.1 0.5]    1]); % PRISMATIC Link

            self.model = SerialLink(link,'name',self.name);
            self.model.plotopt = {'noshadow','noarrow','noshading','nowrist','nojaxes'};
        end    
    end
end