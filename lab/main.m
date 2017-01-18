system('mkdir big');
setenv('filename','big/bigger_picture_');
system('ffmpeg -i led.mp4 -r 0.1 $filename%d.bmp');

[x_axis_frame_size,y_axis_frame_size,x_axis_start_point,y_axis_start_point] = pick_points('big/bigger_picture_1.bmp')

setenv('width',num2str(x_axis_frame_size));
setenv('height',num2str(y_axis_frame_size));
setenv('x_orig',num2str(x_axis_start_point));
setenv('y_orig',num2str(y_axis_start_point));


system('ffmpeg -i led.mp4 -filter:v "crop=$width:$height:$x_orig:$y_orig" out.mp4');

%%% burada büyük resim bitiyor


system('mkdir extracted_pictures');
setenv('filename','extracted_pictures/extracted_');
system('ffmpeg -i out.mp4 -r 60 $filename%d.bmp');

put_some_space(5);


frame=imread('extracted_pictures/extracted_1.bmp');

put_some_space(5);
disp('Pick the (center of the LED) point for clock')
imshow(frame);
k = waitforbuttonpress;
point_clk = get(gca,'CurrentPoint');  %button down detected

put_some_space(5);
disp('Pick the (center of the LED) point for  data')
imshow(frame);
k = waitforbuttonpress;
point_data = get(gca,'CurrentPoint');  %button down detected
close all;


point_clk_y = round(point_clk(1,1,1));
point_clk_x = round(point_clk(1,2,1));

point_data_y = round(point_data(1,1,1));
point_data_x = round(point_data(1,2,1));


[fff,file_num]=system(' (ls -l extracted_pictures | grep -v ^l | wc -l)');

file_num=str2num(file_num);


put_some_space(5);
disp('Processing started...')
disp('In a few seconds you will see the resulting message')


for ii=1:file_num-1
    str = ['extracted_pictures/extracted_' num2str(ii) '.bmp'];
    frame=imread(str);
    
    sdf = frame(point_clk_x-20:point_clk_x+20,point_clk_y-20:point_clk_y+20,:);
    clk(ii) = mean(mean(mean(sdf)));
    
    sdf = frame(point_data_x-20:point_data_x+20,point_data_y-20:point_data_y+20,:);
    data(ii) = mean(mean(mean(sdf)));
    
    if ii==round(file_num/2)
        put_some_space(5); disp('Whoa, We`re Halfway Through')
    end
    
end


figure; plot(clk);
figure; plot(data);

data= uint8(data > mean(data));
clk = uint8(clk > mean(clk));

kk=1;
for ii=1:length(clk) - 1
    if clk(ii) ==0 && clk(ii+1)==1
        extracted_data(kk) = (data(ii));
        kk = kk+1;
    end;
end;

figure;plot(extracted_data);

for ii=1:length(extracted_data)-18
    if extracted_data(ii:ii+18) == [1 1 1 0 0 0 1 0 0 1 0 0 1 0 1 0 1 0 1]
        put_some_space(2);
        disp(['FOUND! at point ' num2str(ii)]);
        put_some_space(2);
        fnd_pnt=ii+19;
        break;
    end
end

while (fnd_pnt + 8 < length(extracted_data))
    char(double(extracted_data(fnd_pnt:fnd_pnt+7)) * [128 64 32 16 8 4 2 1]')
    fnd_pnt = fnd_pnt + 8;
end


%k=waitforbuttonpress;


