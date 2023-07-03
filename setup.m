function setup
    Can = readtable('Candidates.xlsx','Sheet','Sheet1');
    Can = Can(1:50,:);
    ctracks = zeros(height(Can),1);
    for i = 1:height(Can)
        if strcmp(cell2mat(Can.Track(i)),'CS')
            ctracks(i) = 1;
        end
        if strcmp(cell2mat(Can.Track(i)),'C')
            ctracks(i) = 2;
        end
        if strcmp(cell2mat(Can.Track(i)),'S')
            ctracks(i) = 3;
        end
        if strcmp(cell2mat(Can.Track(i)),'E')
            ctracks(i) = 4;
        end
        if strcmp(cell2mat(Can.Track(i)),'V')
            ctracks(i) = 5;
        end
    end
    Can.Track = ctracks;
    Can.nextSlot = zeros(1, height(Can))';
    Can.endSlot = zeros(1, height(Can))';
    Next = zeros(1, height(Can))';
    ID = Can.ID;
    Iteration = zeros(1, height(Can))';
    Scheduled = zeros(1, height(Can))';
    SlotofDay = zeros(1, height(Can))';
    RoundsDone = zeros(1, height(Can))';
    upNext = table(ID, Next, Iteration, Scheduled, SlotofDay, RoundsDone);

    Result = table(Results);
    save('upNext.mat', 'upNext');
    save('Candidates.mat', 'Can');
    save('NextRound.mat', 'Can');
    save('Result')
    Int = readtable('Interviewers.xlsx','Sheet','Sheet1');
    Free = randi([0 1], 30, 8);%getRandomarray();%
    FreeSlots = repelem(Free, 1, 4);
    Int.Free = FreeSlots;
    tracks = Int.Track;
    Int.validSlots = zeros(1, height(Int))';

    
    for i = 1:length(tracks)
        t = split(cell2mat(tracks(i)),',');
        temp = zeros(1,length(t));
        for j = 1:length(t)
            if strcmp(t(j),'CS')
                temp(j) = 1;
            end
            if strcmp(t(j),'C')
                temp(j) = 2;
            end
            if strcmp(t(j),'S')
                temp(j) = 3;
            end
            if strcmp(t(j),'E')
                temp(j) = 4;
            end
            if strcmp(t(j),'V')
                temp(j) = 5;
            end
            if strcmp(t(j),'Manager')
                temp(j) = 6;
            end
            if strcmp(t(j),'HR')
                temp(j) = 7;
            end
        end
        Int.Track(i) = {temp};
    end
    save('Interviewers.mat', 'Int');
end