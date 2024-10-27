classdef ToyBot < RobotBaseClass

    properties(Access = public)   
        plyFileNameStem = 'ToyBot';
    end

    methods (Access = public) 
        %% Define robot Function  
        function self = ToyBot(baseTr)
			self.CreateModel();
            if nargin < 1			
				baseTr = transl(0,0,0);				
            end
            self.model.base =  baseTr  ;%self.model.base.T * 
            
            self.PlotAndColourRobot();        
        end

        %% Create the robot model
        function CreateModel(self)
            link(0) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(30));
            link(1) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(0)); 
            link(2) = Link('d',0.15,'a',0,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(30));
            link(3) = Link('d',0.15,'a',0.1,'alpha',pi/2,'qlim',deg2rad([0 0]),'offset',deg2rad(30)); 
            link(4) = Link('d',0.3,'a',0.1,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(30));
            link(5) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(30)); 
            link(6) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(30));
            link(7) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(30));

            self.model = SerialLink(link,'name',self.name);
            self.model.plotopt = {'noshadow','noarrow','noshading','nowrist','nojaxes'};
        end    
    end
end
