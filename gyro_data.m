clc;  
clear;  
data = load('��ֱ��.txt');
data = data(:, 2:4)*3600;
%Get the standard deviation of Allan, and describe it with 100 points
[A, B] = allan(data, 100, 100);         %��Allan��׼���100����������  
%Double logarithmic coordinate drawing  
loglog(A, B, 'o');                  %��˫��������ͼ  
xlabel('ƽ��ʱ��:sec');                
ylabel('Allan��׼��:deg/h');              
legend('X axis','Y axis','Z axis'); 
grid on;                           
hold on;                           
%fitting  
C(1, :) = nihe(A', (B(:,1)').^2, 2)';   %���  
C(2, :) = nihe(A', (B(:,2)').^2, 2)';  
C(3, :) = nihe(A', (B(:,3)').^2, 2)';  
  
Q = sqrt(abs(C(:, 1) / 3));          %Quantization noise, unit: deg/h, curvature -1������������λ��deg/h  ��  ����-1
N = sqrt(abs(C(:, 2) / 1)) / 60;    %Angle random walk, unit: deg/h^0.5 curvature -1/2�Ƕ�������ߣ���λ��deg/h^0.5  ����-1/2
Bs = sqrt(abs(C(:, 3))) / 0.6643;   %Zero offset instability, unit: deg/h curvature 0��ƫ���ȶ��ԣ���λ��deg/h      ����0
K = sqrt(abs(C(:, 4) * 3)) * 60;    %Angular rate wandering, unit: deg/h/h^0.5���������ߣ���λ��deg/h/h^0.5  
R = sqrt(abs(C(:, 5) * 2)) * 3600;  %Rate slope, unit: deg/h/h����б�£���λ��deg/h/h  
  
fprintf('��������      X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h\n', Q(1), Q(2), Q(3));  
fprintf('�Ƕ��������  X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h^0.5\n', N(1), N(2), N(3));  
fprintf('��ƫ���ȶ���  X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h\n', Bs(1), Bs(2), Bs(3));  
fprintf('����������    X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h/h^0.5\n', K(1), K(2), K(3));  
fprintf('����б��      X�᣺%f Y�᣺%f Z�᣺%f  ��λ��deg/h/h\n', R(1), R(2), R(3));  
  
D(:, 1) = sqrt(C(1,1)*A.^(-2) + C(1,2)*A.^(-1) + C(1,3)*A.^(0) + C(1,4)*A.^(1) + C(1,5)*A.^(2));    %������Ϻ���  
D(:, 2) = sqrt(C(2,1)*A.^(-2) + C(2,2)*A.^(-1) + C(2,3)*A.^(0) + C(2,4)*A.^(1) + C(2,5)*A.^(2));  
D(:, 3) = sqrt(C(3,1)*A.^(-2) + C(3,2)*A.^(-1) + C(3,3)*A.^(0) + C(3,4)*A.^(1) + C(3,5)*A.^(2));  
  
loglog(A, D);  