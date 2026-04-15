T = readtable('Mall_Customers.csv');

G = grp2idx(categorical(T{:,2}));

Age = T{:,3};
Income = T{:,4};
Score = T{:,5};

X = [Age, Income, Score, G];
X = zscore(X);

k = 3;
[idx, C] = kmeans(X, k);

gscatter(Income, Score, idx);
xlabel('Годовой доход');
ylabel('Оценка расходов');
title('Сегментация клиентов с использованием k-средств');
grid on;