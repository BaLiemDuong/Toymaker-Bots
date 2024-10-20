classdef Environment < handle
    properties
    end
    methods (Static)
    %% Function to place floor texture
        function floor()
            surf([-2,-2;2,2],[-2.5,1;-2.5,1],[0,0;0,0], ...
                'CData',imread('tilefloor.jpg'),'FaceColor','texturemap');
        end
    %% Functions to place objects
        % function place_object(name, x,y,z)
        %     object = PlaceObject(name,[x,y,z]);
        %     vertices = get(object,'Vertices');
        %     transformedVertices = [vertices,ones(size(vertices,1),1)];
        %     set(object,'Vertices',transformedVertices(:,1:3));
        % end
        function fence1(x1,y1,z1)
            object = PlaceObject('barrier1.5x0.2x1m.ply',[x1,y1,z1]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(pi/2);
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function fence2(x2,y2,z2)
            object = PlaceObject('barrier1.5x0.2x1m.ply',[x2,y2,z2]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(-pi/2);
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function fence3(x3,y3,z3)
            object = PlaceObject('barrier1.5x0.2x1m.ply',[x3,y3,z3]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(deg2rad(-30));
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function fence4(x4,y4,z4)
            object = PlaceObject('barrier1.5x0.2x1m.ply',[x4,y4,z4]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(deg2rad(30));
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function conveyer1(x5,y5,z5)
            object = PlaceObject('beltconverter.ply',[x5,y5,z5]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function conveyer2(x6,y6,z6)
            object = PlaceObject('beltconverter.ply',[x6,y6,z6]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function table(x7,y7,z7)
            object = PlaceObject('tableBlue1x1x0.5m.ply',[x7,y7,z7]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function button(x8,y8,z8)
            object = PlaceObject('emergencyStopButton.ply',[x8,y8,z8]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function car_base(x9,y9,z9)
            object = PlaceObject('car_base.ply',[x9,y9,z9]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function car_body(x10,y10,z10)
            object = PlaceObject('car_body.ply',[x10,y10,z10]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function wheels(x11,y11,z11)
            object = PlaceObject('wheels_axial.ply',[x11,y11,z11]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
    end
end
