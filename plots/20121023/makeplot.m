function makeplot()

plot_2008_republican_presidential_primary_tx_harris();
plot_2008_democratic_presidential_primary_tx_harris();
plot_2012_republican_presidential_primary_tx_harris();
plot_2012_democratic_presidential_primary_tx_harris();


%%
function [filename] = plot_2012_republican_presidential_primary_tx_harris()

year = '2012';
election = 'Republican Primary';
event = 'President';
county = 'Harris County';
state = 'TX';

date_fn = '20120529';
election_fn = 'republican_primary';
event_fn = 'president';
county_fn = 'harris';
state_fn = 'tx';

plot_filename = [date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '.png'];

candidates = {'Paul','Gingrich','Davies','Santorum','Roemer','Huntsman','Romney','Bachmann','Uncommitted'};

cmap = [ 0 .8 .8; ... % Paul
         0 .5  0; ... % Gingrich
         1 .5 .2; ... % Davies
        .5 .5  0; ... % Santorum
         0 .5  0; ... % Roemer
         0  0  1; ... % Huntsman
         1  0  0; ... % Romney
         1 .7 .7; ... % Bachmann
         0  0  0];    % Uncommitted

data_dir = ['../../data/' state_fn '/' county_fn '/' date_fn '_' election_fn '_' state_fn '_' county_fn '/'];
data1_filename = [data_dir '/' date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '_1.txt'];
data2_filename = [data_dir '/' date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '_2.txt'];

data1 = load(data1_filename);

% when copying the text from the pdf, it copies the columns in an odd
% order (note Percent Turnout is between Roemer and Huntsman and Election
% Ballots Cast is after Bachmann)

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Ron Paul
% 06 Newt Gingrich
% 07 John Davies
% 08 Rick Santorum
% 09 Charles "Buddy" Roemer
% 10 Percent Turnout
% 11 Jon Huntsman
% 12 Mitt Romney
% 13 Michele Bachmann
% 14 Election Ballots Cast

% there wasn't enough space per page to fit all columns in the original
% pdf, so the next file is a continuation (starting from p.33 in the pdf)
data2 = load(data2_filename);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Percent Turnout
% 06 "Uncommitted"
% 07 Totals
% 08 Election Ballots Cast

% convert from raw vote totals to percentages

allvotes = [data1(:,[5:9 11:13]) data2(:,6)];
totals = data2(:,7);
allpercents = bsxfun(@rdivide, allvotes, totals);

% plot percents against precinct size for each candidate

close
figure(1)
hold on
for i = 1:size(allpercents,2);
  plot(totals, allpercents(:,i), '.', 'Color', cmap(i,:))
end
title([year ' ' election ' (' event ') - ' county ', ' state ' - Per-Precinct Election Results'])
xlabel('Total ballots in precinct')
ylabel('Percent vote share')
legend(candidates,'Location','BestOutside')
print('-dpng', '-f1', plot_filename)


%%
function [plot_filename] = plot_2012_democratic_presidential_primary_tx_harris()

year = '2012';
election = 'Democratic Primary';
event = 'President';
county = 'Harris County';
state = 'TX';

date_fn = '20120529';
election_fn = 'democratic_primary';
event_fn = 'president';
county_fn = 'harris';
state_fn = 'tx';

plot_filename = [date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '.png'];

candidates = {'Wolfe', 'Ely', 'Obama', 'Richardson'};

cmap = [ 1  0  0; ... % Wolfe
         0 .8  0; ... % Ely
         0  0  1; ... % Obama
        .5  0 .5];    % Richardson

data_dir = ['../../data/' state_fn '/' county_fn '/' date_fn '_' election_fn '_' state_fn '_' county_fn '/'];
data_filename = [data_dir '/' date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '.txt'];

data = load(data_filename);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 John Wolfe
% 06 Bob Ely
% 07 Barack Obama
% 08 Darcy G. Richardson
% 09 Totals
% 10 Percent Turnout
% 11 Election Ballots Cast

allvotes = data(:,5:8);
totals = data(:,9);
allpercents = bsxfun(@rdivide, allvotes, totals);

close
figure(1)
hold on
for i = 1:size(allpercents,2);
  plot(totals, allpercents(:,i), '.', 'Color', cmap(i,:))
end
title([year ' ' election ' (' event ') - ' county ', ' state ' - Per-Precinct Election Results'])
xlabel('Total ballots in precinct')
ylabel('Percent vote share')
legend(candidates,'Location','BestOutside')
print('-dpng', '-f1', plot_filename)

%%
function [plot_filename] = plot_2008_republican_presidential_primary_tx_harris()

year = '2008';
election = 'Republican Primary';
event = 'President';
county = 'Harris County';
state = 'TX';

date_fn = '20080304';
election_fn = 'republican_primary';
event_fn = 'president';
county_fn = 'harris';
state_fn = 'tx';

plot_filename = [date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '.png'];

candidates = {'Hunter','Thompson','Cort','McCain','Paul','Giuliani','Tran','Huckabee','Keyes','Romney','Uncommitted'};

cmap = [ 0 .5  0; ... % Hunter
         0  0  0; ... % Thompson
         1 .5 .2; ... % Cort
         1  0  0; ... % McCain
         0 .8 .8; ... % Paul
        .7  1 .7; ... % Giuliani
         1 .7 .7; ... % Tran
         0  0  1; ... % Huckabee
        .7 .7  1; ... % Keyes
        .5  0  0; ... % Romney
         0  0  0];    % Uncommitted

data_dir = ['../../data/' state_fn '/' county_fn '/' date_fn '_' election_fn '_' state_fn '_' county_fn '/'];
data1_filename = [data_dir '/' date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '_1.txt'];
data2_filename = [data_dir '/' date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '_2.txt'];

data1 = load(data1_filename);

% 01 Precinct
% 02 Early Voting Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Duncan Hunter
% 06 Fred Thompson
% 07 Hugh Cort
% 08 John McCain
% 09 Ron Paul
% 10 Percent Turnout
% 11 Rudy Giuliani
% 12 Hoa Tran
% 13 Mike Huckabee
% 14 Election Day Ballots Cast

data2 = load(data2_filename);

% 01 Precinct
% 02 Early Voting Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Percent Turnout
% 06 Alan Keyes
% 07 Mitt Romney
% 08 "Uncommitted"
% 09 Totals
% 10 Election Day Ballots Cast

allvotes = [data1(:,[5:9 11:13]) data2(:,6:8)];
totals = data2(:,9);
allpercents = bsxfun(@rdivide, allvotes, totals);

close
figure(1)
hold on
for i = 1:size(allpercents,2);
  plot(totals, allpercents(:,i), '.', 'Color', cmap(i,:))
end
title([year ' ' election ' (' event ') - ' county ', ' state ' - Per-Precinct Election Results'])
xlabel('Total ballots in precinct')
ylabel('Percent vote share')
legend(candidates,'Location','BestOutside')
print('-dpng', '-f1', plot_filename)


%%
function [plot_filename] = plot_2008_democratic_presidential_primary_tx_harris()

year = '2008';
election = 'Democratic Primary';
event = 'President';
county = 'Harris County';
state = 'TX';

date_fn = '20080304';
election_fn = 'democratic_primary';
event_fn = 'president';
county_fn = 'harris';
state_fn = 'tx';

plot_filename = [date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '.png'];

candidates = {'Obama','Dodd','Clinton','Biden','Richardson','Edwards'};

cmap = [ 0  0  1; ... % Obama
         1 .7 .7; ... % Dodd
         1  0  0; ... % Clinton
        .7 .7  1; ... % Biden
        .5  0 .5; ... % Richardson
        .7  1 .7];    % Edwards

data_dir = ['../../data/' state_fn '/' county_fn '/' date_fn '_' election_fn '_' state_fn '_' county_fn '/'];
data_filename = [data_dir '/' date_fn '_' election_fn '_' event_fn '_' state_fn '_' county_fn '.txt'];

data = load(data_filename);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Barack Obama
% 06 Christopher J. Dodd
% 07 Hillary Clinton
% 08 Joe Biden
% 09 Bill Richardson
% 10 Percent Turnout
% 11 John Edwards
% 12 Totals
% 13 Election Ballots Cast

allvotes = data(:,[5:9 11]);
totals = data(:,12);
allpercents = bsxfun(@rdivide, allvotes, totals);

close
figure(1)
hold on
for i = 1:size(allpercents,2);
  plot(totals, allpercents(:,i), '.', 'Color', cmap(i,:))
end
title([year ' ' election ' (' event ') - ' county ', ' state ' - Per-Precinct Election Results'])
xlabel('Total ballots in precinct')
ylabel('Percent vote share')
legend(candidates,'Location','BestOutside')
print('-dpng', '-f1', plot_filename)
