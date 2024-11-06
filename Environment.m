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
        function fence1(pos)
            object = PlaceObject('barrier1.5x0.2x1m.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(pi/2);
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function fence2(pos)
            object = PlaceObject('barrier1.5x0.2x1m.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(-pi/2);
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function fence3(pos)
            object = PlaceObject('barrier1.5x0.2x1m.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(deg2rad(-30));
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function fence4(pos)
            object = PlaceObject('barrier1.5x0.2x1m.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(deg2rad(30));
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function conveyer1(pos)
            object = PlaceObject('beltconverter.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function conveyer2(pos)
            object = PlaceObject('beltconverter.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function table(pos)
            object = PlaceObject('table.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function button(pos)
            object = PlaceObject('button.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function object = car_base(pos)
            object = PlaceObject('car_base.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function object = car_body(pos)
            object = PlaceObject('car_body.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
        function object = wheels(pos)
            object = PlaceObject('wheels_axial.ply',pos);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)];
            set(object,'Vertices',transformedVertices(:,1:3));
        end
    end
end
