%DNN��н�ģ
%Author:Liujiangfan 
%Time  :2018.5
%Github:https://github.com/LSayhi
%Addres:SCHOOL OF ELECTRONIC ENGINEERING at BUPT,Beijing ,China


%˵��
%������������ΪƵ�ʣ���׼��/60G��������ھ���/29.6um��������߿�(/5.1um)
%�����������ΪS11ģֵ��S21ģֵ��S11��λ�������ƣ���S21��λ�������ƣ�
%�������������׼������ܵ���ģ�Ͳ���������������

%����
num_inputlayer=3;%�����������
num_outputlayer=4;%�����������

input_train = traininput(1:num_inputlayer,:);%����ѵ��������
output_train= trainoutput(1:num_outputlayer,:);%����ѵ�������
input_test  = testinput(1:num_inputlayer,:);%������Լ�����
output_test = testoutput(1:num_outputlayer,:);%������Լ����

[inputn,inputps]=mapminmax(input_train);%��һ��ѵ��������
[outputn,outputps]=mapminmax(output_train);%��һ��ѵ�������

net=newff(inputn,outputn,[10,10]);
%{'tansig','tansig','purelin'}�������
%�������ز������ÿ����Ԫ��Ŀ�����������������ȷ����

net.trainParam.epochs=10000;%����������1000
net.trainParam.lr=0.01;%ѧϰ��0.1
net.trainParam.goal=0.000001;%Ŀ�������
% net.divideParam.trainRatio = 60/100;  
% net.divideParam.valRatio = 30/100;  
% net.divideParam.testRatio = 10/100; 
%net.divideFcn = '';
net=train(net,inputn,outputn);%ѵ�����úõ�������ģ��

inputn_test=mapminmax('apply',input_test,inputps);
%���Լ������һ������ѵ�����Ĺ�һ�������������ǲ��Լ����Լ����ݹ�һ����
an=sim(net,inputn_test);%�����Լ����뵼��ģ��net����
BPoutput=mapminmax('reverse',an,outputps);
%����һ�����Լ��������ѵ�����Ĳ�������һ����


%��ֱ������ͼ
figure(1);
plot(testinput(1,:),BPoutput([1,3],:),'.')%Ԥ��S11�ķ�ֵ����λ
hold on;
plot(testinput(1,:),output_test([1,3],:),'-')%�����S11��ֵ����λ
legend('Ԥ��S11mag','Ԥ��S11deg','����S11mag','����S11deg')
title('Simulated S by HFSS and predicted S by neural network')

figure(2);
plot(testinput(1,:),BPoutput([2,4],:),'.')%Ԥ��S21�ķ�ֵ����λ
hold on;
plot(testinput(1,:),output_test([2,4],:),'-')%�����S21��ֵ����λ
legend('Ԥ��S21mag','Ԥ��S21deg','����S21mag','����S21deg')
title('Simulated S by HFSS and predicted S by neural network')

%��������ͼ
figure(3);
polar(BPoutput(1,:),BPoutput(3,:),'.');%S11����
hold on;
polar(output_test(1,:),output_test(3,:),'-');%S11Ԥ��
legend('����S11','Ԥ��S11')
title('Simulated S by HFSS and predicted S by neural network')

figure(4);
polar(BPoutput(2,:),BPoutput(4,:),'.');%S21����
hold on;
polar(output_test(2,:),output_test(4,:),'-');%S21Ԥ��
legend('����S21','Ԥ��S21')
title('Simulated S by HFSS and predicted S by neural network')
