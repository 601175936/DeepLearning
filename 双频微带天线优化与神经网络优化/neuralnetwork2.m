%Author:Liujiangfan 
%Time  :2017.12
%@Github:LSayhi
%@SCHOOL OF ELECTRONIC ENGINEERING BUPT
%һ��������Ԥ��S�����ĳ���,����޸�����������
input_neural_num=3;%�����������
output_neural_num=1;%����������
input_train=traininput(1:input_neural_num,:);%����ѵ��������
output_train=trainoutput(1:output_neural_num,:);%����ѵ�������
input_test=testinput(1:input_neural_num,:);%������Լ�����
output_test=testoutput(1:output_neural_num,:);%������Լ����

[inputn,inputps]=mapminmax(input_train);%��һ��ѵ��������
[outputn,outputps]=mapminmax(output_train);%��һ��ѵ�������

net=newff(inputn,outputn,[5,10]);
%�������ز������ÿ����Ԫ��Ŀ�����������������ȷ����
net.trainParam.epochs=1000;%����������1000
net.trainParam.lr=0.1;%ѧϰ��0.1
net.trainParam.goal=0.001;%Ŀ�������

net=train(net,inputn,outputn);%ѵ�����úõ�������ģ��

inputn_test=mapminmax('apply',input_test,inputps);
%���Լ������һ������ѵ�����Ĺ�һ�������������ǲ��Լ����Լ����ݹ�һ����
an=sim(net,inputn_test);%�����Լ����뵼��ģ��net����
BPoutput=mapminmax('reverse',an,outputps);
%����һ�����Լ��������ѵ�����Ĳ�������һ����

figure(1);
plot(testinput(1,:),BPoutput(1,:),'.')%��������Ԥ���S11��ֵ��ͼ��
hold on;
plot(testinput(1,:),testoutput(1,:),'-')%��ͼHFSS�����S11��ֵ��ͼ��
xlabel('frequency/GHz');ylabel('value/dB')
grid on;grid minor;
legend('Ԥ��magS11','����magS11');
title('Simulated S by HFSS and predicted S by neural network')

