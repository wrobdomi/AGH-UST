clear all;
close all;

figure();
Hand = imread('hand.ppm');  % Read my hand.ppm
imshow(Hand)              % Show my hand resolution 64x64 RGB
title('hand.ppm');          % Title my hand...

% figure();                   
% Hand_d = im2double(Hand);   % Optionally could be done 
% imshow(Hand_d);             % with double values
% title('Hand double');       % but then matlab uses values 0 to 1

figure();                     % not 0 to 255 as is now
YCBCR = rgb2ycbcr(Hand);      % We will try the build-in function
imshow(YCBCR);                % and look how it worked for us
title('YCBCR with matlab function'); % and title it

R2Y_M = [ 0.299 0.587 0.114 ; 
          -0.168736 -0.331264 0.5 ;
          0.5 -0.418688 -0.081312 ];  % Matrix to convert RGB to YCbCr
           
Hand_YCbCr=zeros(64,63,3); % Create a matrix for result
for i = 1 : 64
    for j = 1 : 64 % do some maths magic...
        Hand_YCbCr(i,j,1)=Hand(i,j,1)*R2Y_M(1,1)+Hand(i,j,2)*R2Y_M(1,2)...
            +Hand(i,j,3)*R2Y_M(1,3);
        Hand_YCbCr(i,j,2)=Hand(i,j,1)*R2Y_M(2,1)+Hand(i,j,2)*R2Y_M(2,2)...
            +Hand(i,j,3)*R2Y_M(2,3) + 128;
        Hand_YCbCr(i,j,3)=Hand(i,j,1)*R2Y_M(3,1)+Hand(i,j,2)*R2Y_M(3,2)...
            +Hand(i,j,3)*R2Y_M(3,3) + 128;
    end
end % , but wait... i did multiplication with doubles and uint_8 
    % resulting in double ! 

figure();
Hand_YCrCb2 = uint8(Hand_YCbCr); % Let's go back to uint_8 then
imshow(Hand_YCrCb2);            % Here's the result.
title('Hand YCrCb with matrix ');
Hand_result = Hand_YCrCb2;

%%%% Move on to binarisation  now %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Binar_hand=zeros(64,64,1); % Create a matrix for result of binarisation

Ta = 1; % Tresholds for binarisation for Cb
Tb = 186;
Tc = 190; % Tresholds for binarisation for Cr
Td = 255;
for i = 1 : 64
    for j = 1 : 64 % do some maths magic...
            if ( (Hand_result(i,j,2) > Ta) && (Hand_result(i,j,2) < Tb) && (Hand_result(i,j,3) < Td) && (Hand_result(i,j,3) > Tc) )
                Binar_hand(i,j,1)=255;
            else
                Binar_hand(i,j,1)=0;
            end
    end
end 
figure();
imshow(Binar_hand)
title('After binarisation');

% Move on to filtering
Binar_filter = zeros(64,64,1);
Binar_filter = medfilt2(Binar_hand);
figure();
imshow(Binar_filter)
title('After filtering');

% Move on to center gravity
center = Binar_filter; % backup copy 
m_00 = 0;
m_01 = 0;
m_10 = 0;


for i = 1 : 64
    for j = 1 : 64 % do some math magic...
            m_00 = m_00+center(i,j,1);
            m_01 = m_01 + j*center(i,j,1);
            m_10 = m_10 + i*center(i,j,1);
    end
end 
% 
% m_00 = sum(center(:));
% m_01 = sum(center*(1:64).');
% m_10 = sum((1:64)*center);

x_sc = m_10/m_00;
y_sc = m_01/m_00;
x1 = [x_sc 0];
y1 = [0 y_sc];
x2 = [x_sc 1];
y2 = [1 y_sc];
figure();
imshow(center);
%line(x1,x2);
hold on;
plot(y_sc,x_sc,'*');
%line(y1,y2);
title('Gravity centre');