%Author:Liujiangfan 
%Time  :2017.12
%@Github:LSayhi
%@SCHOOL OF ELECTRONIC ENGINEERING BUPT
%һ��������Ԥ��S�����ĳ���,����޸�����������

input_train=traininput(1:4,:);%����ѵ��������
output_train=trainoutput(1:4,:);%����ѵ�������
input_test=testinput(1:4,:);%������Լ�����
output_test=testoutput(1:4,:);%������Լ����

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
plot(testinput(1,:),BPoutput(1:2,:),'.')%��������Ԥ���S11,S12��ֵ��ͼ��
hold on;
plot(testinput(1,:),output_test(1:2,:),'-')%��ͼ�����S11��S12��ֵ��ͼ��
legend('Ԥ��magS11','Ԥ��magS12','����magS11','����magS12')
title('Simulated S by HFSS and predicted S by neural network')

figure(2);
plot(testinput(1,:),BPoutput(3:4,:),'.')%��������Ԥ���S11,S12��λ��ͼ��
hold on;
plot(testinput(1,:),output_test(3:4,:),'-')%��ͼ�����S11��S12��λ��ͼ��
legend('Ԥ��degS11','Ԥ��degS12','����degS11','����degS12')
title('Simulated S by HFSS and predicted S by neural network')

