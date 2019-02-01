clear all;
close all;

figure();
Hand = imread('hand.ppm');  % Read my hand.ppm
imshow(Hand)                % Show my hand resolution 64x64 RGB
title('hand.ppm');          % Title my hand...

Hand_fi = fi(Hand,1,9,0);   % Convert uint8 to fixed point with sign, 9 bits word 8 integer, 0 fraction

% fi : value, sign, wordlength containing sign + frac + integer, fraction 

R2Y_M = [ 0.299 0.587 0.114 ;
          -0.168736 -0.331264 0.5 ;
          0.5 -0.418688 -0.081312 ]; % values of coefficients
      
normal = fi(128,1,9,0); % add 128 to Cb and Cr
coef = fi(R2Y_M,1,18,16);    % Convert double to fixed point with sign, 1 bits per int, 16 fraction

% YCbCr_mul_one = zeros(64,64,9);   %    in   in     in   in    in   in  3 outputs for Y, 3 for Cb, 3 for Cr
% YCbCr_add_one = zeros(64,64,3);   %     |_*_|       |_*_|      |_*_|   1 output for Y, for Cb, for Cr
% YCbCr_final = zeros(64,64,3);     %       |____ + ____|          |     
%                                   %             |_________+______|     
for i = 1 : 64
    for j = 1 : 64 % do some maths magic...
        
        
        YCbCr_mul_one(i,j,1) = Hand_fi(i,j,1)*coef(1,1); % first line mule
        YCbCr_mul_one(i,j,2) = Hand_fi(i,j,2)*coef(1,2); % Y
        YCbCr_mul_one(i,j,3) = Hand_fi(i,j,3)*coef(1,3);
        YCbCr_mul_one_af(i,j,1) = quantize( YCbCr_mul_one(i,j,1), 1, 11, 0);
        YCbCr_mul_one_af(i,j,2) = quantize( YCbCr_mul_one(i,j,2), 1, 11, 0);
        YCbCr_mul_one_af(i,j,3) = quantize( YCbCr_mul_one(i,j,3), 1, 11, 0);
        
        YCbCr_add_one(i,j,1) = YCbCr_mul_one_af(i,j,1)+YCbCr_mul_one_af(i,j,2);
       
        YCbCr_final_Y(i,j) = YCbCr_add_one(i,j,1)+YCbCr_mul_one_af(i,j,3); 
        
        
        
        YCbCr_mul_one(i,j,4) = Hand_fi(i,j,1)*coef(2,1); % first line mule
        YCbCr_mul_one(i,j,5) = Hand_fi(i,j,2)*coef(2,2); % Cb
        YCbCr_mul_one(i,j,6) = Hand_fi(i,j,3)*coef(2,3);
        YCbCr_mul_one_af(i,j,4) = quantize( YCbCr_mul_one(i,j,4), 1, 11, 0);
        YCbCr_mul_one_af(i,j,5) = quantize( YCbCr_mul_one(i,j,5), 1, 11, 0);
        YCbCr_mul_one_af(i,j,6) = quantize( YCbCr_mul_one(i,j,6), 1, 11, 0);
        
        YCbCr_add_one(i,j,2) = YCbCr_mul_one_af(i,j,4)+YCbCr_mul_one_af(i,j,5);
        
        YCbCr_final(i,j,2) = YCbCr_add_one(i,j,2)+YCbCr_mul_one_af(i,j,6); 
        YCbCr_final_Cb(i,j) = YCbCr_final(i,j,2) + normal;
        
        
        YCbCr_mul_one(i,j,7) = Hand_fi(i,j,1)*coef(3,1); % first line mule
        YCbCr_mul_one(i,j,8) = Hand_fi(i,j,2)*coef(3,2); % Cb
        YCbCr_mul_one(i,j,9) = Hand_fi(i,j,3)*coef(3,3);
        YCbCr_mul_one_af(i,j,7) = quantize( YCbCr_mul_one(i,j,7), 1, 11, 0);
        YCbCr_mul_one_af(i,j,8) = quantize( YCbCr_mul_one(i,j,8), 1, 11, 0);
        YCbCr_mul_one_af(i,j,9) = quantize( YCbCr_mul_one(i,j,9), 1, 11, 0);
        
        YCbCr_add_one(i,j,3) = YCbCr_mul_one_af(i,j,7)+YCbCr_mul_one_af(i,j,8);
       
        YCbCr_final(i,j,3) = YCbCr_add_one(i,j,3)+YCbCr_mul_one_af(i,j,9); 
        YCbCr_final_Cr(i,j) = YCbCr_final(i,j,3) + normal;
        
    end
end

final_Y = uint8(YCbCr_final_Y);
final_Cb = uint8(YCbCr_final_Cb);
final_Cr = uint8(YCbCr_final_Cr);

for i= 1:64
    for j=1:64
        final(i,j,1) = final_Y(i,j);
        final(i,j,2) = final_Cb(i,j);
        final(i,j,3) = final_Cr(i,j);
    end
end

figure();
imshow(final);
title('Result fixed point');


figure();                   
Hand_d = im2double(Hand);   % Optionally could be done 
imshow(Hand_d);             % with double values
title('Hand double');       % but then matlab uses values 0 to 1

R2Y_M = [ 0.299 0.587 0.114 ; 
          -0.168736 -0.331264 0.5 ;
          0.5 -0.418688 -0.081312 ];  % Matrix to convert RGB to YCbCr
           
Hand_YCbCr_d=zeros(64,63,3); % Create a matrix for result
for i = 1 : 64
    for j = 1 : 64 % do some maths magic...
        Hand_YCbCr_d(i,j,1)=Hand_d(i,j,1)*R2Y_M(1,1)+Hand_d(i,j,2)*R2Y_M(1,2)...
            +Hand_d(i,j,3)*R2Y_M(1,3);
        Hand_YCbCr_d(i,j,2)=Hand_d(i,j,1)*R2Y_M(2,1)+Hand_d(i,j,2)*R2Y_M(2,2)...
            +Hand_d(i,j,3)*R2Y_M(2,3) + 128;
        Hand_YCbCr_d(i,j,3)=Hand_d(i,j,1)*R2Y_M(3,1)+Hand_d(i,j,2)*R2Y_M(3,2)...
            +Hand_d(i,j,3)*R2Y_M(3,3) + 128;
    end
end % , but wait... i did multiplication with doubles and uint_8 
    % resulting in double ! 
figure();
imshow(Hand_YCbCr_d);            
title('Hand YCrCb double');

Hand_vivado = imread('out_01.ppm');  % Read my hand.ppm
figure();
imshow(Hand_vivado);
title('Result from sim Vivado');

K = imabsdiff(final,Hand_vivado);
figure();
imshow(K);
title('ABS diff');

%%%%%%%%%%% BINARISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hand_result = Hand_YCbCr_d;

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
