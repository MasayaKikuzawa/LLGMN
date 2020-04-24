%% 初期設定
data_siz = 800;
class_siz = 4;
conponent_siz = 2;
vector_siz = 6;
study_rate = 0.001;
Ikm = zeros(class_siz,conponent_siz);
Okm = zeros(class_siz,conponent_siz);
Ik = zeros(class_siz);
Yk = zeros(data_siz,class_siz) ;
weights = rand(class_siz,conponent_siz,vector_siz);
ow = zeros(class_siz,conponent_siz,vector_siz);
inputdata = zeros(800,6);

filename01 ='dis_sig.csv';
filename02 ='dis_T_sig.csv';
filename03 ='lea_sig.csv';
filename04 ='lea_T_sig.csv';

disdata = readmatrix(filename01);
distdata= readmatrix(filename02);
leadata = readmatrix(filename03);
leatdata= readmatrix(filename04);

in_siz = size(inputdata);

for i = 1:in_siz(1)
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
    Yk(a,:) = Ik;
end








