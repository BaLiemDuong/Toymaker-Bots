classdef Environment < handle
    properties
    end
    methods (Static)
        % function place_fence(x,y,z, rotz)
        %     fence = PlaceObject('barrier1.5x0.2x1m.ply',[x,y,z]);
        %     verts = [get(fence,'Vertices'),ones(size(get(fence,'Vertices'),1),1)]*trotz(rotz);
        %     verts(:,2) = verts(:,2)*(5/3);
        %     set(fence,'Vertices',verts(:,1:3));
        % end
        % function place_stationary_objects(table, button, belt1, belt2)
        %     PlaceObject('tableBlue1x1x0.5m.ply',table);
        %     PlaceObject('emergencyStopButton.ply',button);
        %     PlaceObject('beltconverter.PLY',belt1);
        %     PlaceObject('beltconverter.PLY',belt2);
        % end
        % function car_parts(c1)%, c2, c3, w1, w2, w3, w4)
        %     PlaceObject('car_base.ply',c1);
        % end

        % function place_object(name, x,y,z, rotx,roty,rotz)
        %     object = PlaceObject(name,[x,y,z]);
        %     verts = [get(object,'Vertices'),ones(size(get(object,'Vertices'),1),1)]*trotz(rotx)*trotz(roty)*trotz(rotz);
        %     verts(:,2) = verts(:,2)*(5/3);
        %     set(object,'Vertices',verts(:,1:3));
        % end

        function place_object(name, x,y,z, rotx,roty,rotz)
            object = PlaceObject(name,[x,y,z]);
            vertices = get(object,'Vertices');
            transformedVertices = [vertices,ones(size(vertices,1),1)]*trotz(rotx)*trotz(roty)*trotz(rotz);
            set(object,'Vertices',transformedVertices(:,1:3));
        end

    end
end
