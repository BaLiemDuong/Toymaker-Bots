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
            self.model.base =  baseTr;
            
            self.PlotAndColourRobot();        
        end

        %% Create the robot model
        function CreateModel(self)
            link(1) = Link('d',0,'a',0,'alpha',0,'qlim',deg2rad([-45 45]),'offset',deg2rad(0)); 
            link(2) = Link('d',0.1,'a',0,'alpha',0,'qlim',deg2rad([-90 90]),'offset',deg2rad(0));
            link(3) = Link('d',0,'a',0.005,'alpha',pi/2,'qlim',deg2rad([-90 90]),'offset',deg2rad(0)); 
            link(4) = Link('d',-0.05,'a',0.1,'alpha',-pi/2,'qlim',deg2rad([-90 90]),'offset',deg2rad(0));
            link(5) = Link('d',0.1,'a',-0.02,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(0)); 
            link(6) = Link('d',-0.02,'a',0.02,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(0));
            link(7) = Link('d',0.05,'a',-0.015,'alpha',0,'qlim',deg2rad([0 0]),'offset',deg2rad(0));

            self.model = SerialLink(link,'name',self.name);
            self.model.plotopt = {'noshadow','noarrow','noshading','nowrist','nojaxes'};
        end    
    end
end