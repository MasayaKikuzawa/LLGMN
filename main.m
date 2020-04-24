%% 初期設定


data_siz = 2;
input_siz = 2;
output_siz = 4;
class_siz = 4;
conponent_siz = 2;
vector_siz = 6;
progress = 0;
cognitive_rate = 0;
study_rate = 0.001;
Ikm = zeros(class_siz,conponent_siz);
Okm = zeros(class_siz,conponent_siz);
Ik= zeros(class_siz);
weights = rand(class_siz,conponent_siz,vector_siz);
ow = zeros(class_siz,conponent_siz,vector_siz);
inputdata01 = zeros(200,6);
inputdata02 = zeros(200,6);
inputdata03 = zeros(200,6);
inputdata04 = zeros(200,6);
inputdata = zeros(800,6);

filename01 ='dis_sig.csv';
filename02 ='dis_T_sig.csv';
filename03 ='lea_sig.csv';
filename04 ='lea_T_sig.csv';

disdata = readmatrix(filename01);
distdata= readmatrix(filename02);
leadata = readmatrix(filename03);
leatdata= readmatrix(filename04);

learn01 = leadata(1:200,:);
learn02 = leadata(201:400,:);
learn03 = leadata(401:600,:);
learn04 = leadata(601:800,:);

learnt01 = leatdata(1:200,:);
learnt02 = leatdata(201:400,:);
learnt03 = leatdata(401:600,:);
learnt04 = leatdata(601:800,:);

%for i = 1:200
%    inputdata01(i,:)= [1 learn01(1,:) times(learn01(i,1),learn01(i,1)) times(learn01(i,1),learn01(i,2)) times(learn01(i,2),learn01(i,2))];
%    inputdata02(i,:)= [1 learn02(1,:) times(learn02(i,1),learn02(i,1)) times(learn02(i,1),learn02(i,2)) times(learn02(i,2),learn02(i,2))];
%    inputdata03(i,:)= [1 learn03(1,:) times(learn03(i,1),learn03(i,1)) times(learn03(i,1),learn03(i,2)) times(learn03(i,2),learn03(i,2))];
%    inputdata04(i,:)= [1 learn04(1,:) times(learn04(i,1),learn04(i,1)) times(learn04(i,1),learn04(i,2)) times(learn04(i,2),learn04(i,2))];
%end

for i = 1:800
    inputdata(i,:) = [1 disdata(1,:) times(disdata(i,1),disdata(i,1)) times(disdata(i,1),disdata(i,2)) times(disdata(i,2),disdata(i,2))];
end
in_siz = size(inputdata);

%% 学習







%% 実行

for a =1:in_siz(1)
    for i = 1:in_siz(2)
        weights(class_siz,conponent_siz,i)= 0;
        ow(:,:,i) = inputdata(a,i)*weights(:,:,i); 
    end
    Ikm = sum(ow,3);
    ikm_siz=size(Ikm);
    for i = 1:ikm_siz(1)
        for j = 1:ikm_siz(2)
            Okm(i,j)= exp(Ikm(i,j))/sum(exp(Ikm),'all');
        end
    end
    Ik = sum(Okm,2);
    disp(Ik)
end








