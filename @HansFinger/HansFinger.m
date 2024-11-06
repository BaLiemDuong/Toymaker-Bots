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
            link(1) = Link('theta', 0, 'a', 0, 'alpha', 0, 'qlim', [0.1 0.5], 'prismatic');
            % link(1) = Link([0     0       0       [0.1 0.5]    1]); % PRISMATIC Link

            self.model = SerialLink(link,'name',self.name);
            self.model.plotopt = {'noshadow','noarrow','noshading','nowrist','nojaxes'};
        end        
    end
end
