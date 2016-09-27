clc;
close all;
clear all;
%Author Muhammah Imran%
matrix_inputdta=xlsread('data.xlsx')
% m is the given dataset matrix
% first we find the unique element from last coloum of the matrix m which
% is actually number of labels e.g we label first three by 1 and last one by 2 in thhis data but it is not contant we can chane the values of the dataset.
lable=unique(matrix_inputdta(:,size(matrix_inputdta,2)))
% we define the matrix with zeroz value size of the matrix is rows of
% matrix equal to lable and colum is equal to the number of colum less then
% one because last colum for the label in data.
table=zeros(size(lable,1),size(matrix_inputdta,2)-1)
for i=1:size(lable,1)
    class_oflabel=find(matrix_inputdta(:,size(matrix_inputdta,2))==lable(i))
    for d=1:size(class_oflabel,1)
        for f=1:size(matrix_inputdta,2)-1
            if matrix_inputdta(class_oflabel(d,1),f)==1
                table(lable(i,1),f)=table(lable(i,1),f)+1;
            end
        end
    end
end
%sparse matrix method but not generic

% nozdata=sparse(b);
% lfff=unique(nozdata(:,4));
% rind=find(lfff(1,1)==nozdata(:,4))
% c1samp=nozdata(rind,1:3);
% rind=find(lfff(2,1)==nozdata(:,4))
% c2samp=nozdata(rind,1:3);
% countc1=nnz(c1samp);
% countc2=nnz(c2samp);
%//////////////////////////////////////////////////////////////%
%a=sparse(m);
prior_prob=table/size(lable,1);           %Pr(c_i)  :is prior probabilty of ith class.
conditional_prob=table/size(matrix_inputdta,1); %pr(c_i|t):is conditional probability of ith class                                        
complment_prob=1-conditional_prob;                 %Pr(~t)   :is complment probabilty of term t
total_prob_oft=table/size(lable,1);  %Pr(t)    :is probability of term t in a given data set..
conditional_complyment=1-total_prob_oft;%Pr(~c_i|t):is conditional complementry probabilty of ith class.
sum_efig=0;
sum1=0;
sum2=0;

for j=1:size(table,1)
    for k = 1:size(table,2)
       sum_efig = (prior_prob.*log10(prior_prob))+sum_efig;
    end
end
%end of calculation of first part of IG equation
for l=1:size(table,1)
      for matrix_inputdta=1:size(table,2)  
           
         sum1= ( conditional_prob.*log(conditional_prob))+sum1;            
      end
      
end
%end of calculation of second part of IG equation.
   for d= 1:size(table,1)
        for n=1:size(table,2)
               sum2= complment_prob.*log10(complment_prob)+sum2; 
        end
   end
     ig = sum_efig;
     ig1=total_prob_oft.*sum1;
     ig2=conditional_complyment.*sum2;
     IG=-(ig)+(ig1)+(ig2);
     final=sort(IG);
     plot(IG);
     plot(final);
    