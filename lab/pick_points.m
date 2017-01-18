function [x_axis_frame_size,y_axis_frame_size,x_axis_start_point,y_axis_start_point] = pick_points(image_str)
frame=imread(image_str);

    imshow(frame);
    
    disp('Click for LEFT UP');
    k = waitforbuttonpress;
    point1 = get(gca,'CurrentPoint');  %button down detected


    disp('Click for LEFT DOWN');
    k = waitforbuttonpress;
    point2 = get(gca,'CurrentPoint');  %button down detected


    disp('Click for RIGTH DOWN');
    k = waitforbuttonpress;
    point3 = get(gca,'CurrentPoint');  %button down detected


    disp('Click for RIGHT UP');
    k = waitforbuttonpress;
    point4 = get(gca,'CurrentPoint');  %button down detected
    picked(:,1)=point1(1,1:2,1);
    picked(:,2)=point2(1,1:2,1);
    picked(:,3)=point3(1,1:2,1);
    picked(:,4)=point4(1,1:2,1);
    close all;


picked

corner1 = round(min(picked(1,:)));
corner2 = round(max(picked(1,:)));
corner3 = round(min(picked(2,:)));
corner4 = round(max(picked(2,:)));

x_axis_frame_size = corner2-corner1;
x_axis_start_point= corner1;

y_axis_frame_size = corner4-corner3;
y_axis_start_point= corner3;
end
