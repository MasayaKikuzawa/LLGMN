%% 初期設定
epoch = 10000;
data_siz = 800;
mymister = zeros(class_siz,conponent_siz,vector_siz,data_siz);
deltaw = zeros(class_siz,conponent_siz,vector_siz);
mister = 0;
class_siz = 4;
conponent_siz = 2;
vector_siz = 6;
study_rate = 0.001;
Yk = zeros(data_siz,class_siz) ;
tyk = zeros(data_siz,class_siz) ;
weights = rand(class_siz,conponent_siz,vector_siz);
ow = zeros(class_siz,conponent_siz,vector_siz);
inputdata = zeros(800,6);

traindata = zeros(800,6);

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
    traindata(i,:) = [1 leadata(1,:) times(leadata(i,1),leadata(i,1)) times(leadata(i,1),leadata(i,2)) times(leadata(i,2),leadata(i,2))];
end
in_siz = size(inputdata);

trainweights = weights;

[tyk aOkm] = forward(data_siz,class_siz,conponent_siz,vector_siz,weights,traindata);

Jn = -1*sum(dot(leatdata(1,:),log(tyk(1,:))));


for i = 1:data_siz
    for j = 1:class_siz
        for k = 1:conponent_siz
            for l = 1:in_siz(2)
                mymister(j,k,l,i) = (tyk(i,j)-leatdata(i,j))*aOkm(j,k,i)/tyk(i,j)*traindata(i,l);
            end
        end
    end
end

deltaw = -1*study_rate*sum(mymister,4);
disp(trainweights)
trainweights =trainweights - deltaw;
disp(trainweights)






%% 実行

[Yk Okm] = forward(data_siz,class_siz,conponent_siz,vector_siz,weights,inputdata);


function [Yk aOkm] = forward(data_siz,class_siz,conponent_siz,vector_siz,weights,inputdata)
    aOkm = zeros(class_siz,conponent_siz,vector_siz,data_siz);
    in_siz = size(inputdata);
    for i =1:in_siz(1)
        for j = 1:in_siz(2)
            weights(class_siz,conponent_siz,j)= 0;
            ow(:,:,j) = inputdata(i,j)*weights(:,:,j);
        end
        Ikm = sum(ow,3);
        ikm_siz=size(Ikm);
        for k = 1:ikm_siz(1)
            for m = 1:ikm_siz(2)
                Okm(k,m)= exp(Ikm(k,m))/sum(exp(Ikm),'all');
                aOkm(k,m,i) = Okm(k,m);
            end
        end
        Ik = sum(Okm,2);
        Yk(i,:) = Ik;
    end
end







