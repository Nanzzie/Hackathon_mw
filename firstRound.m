function firstRound()
    Can = load("Candidates.mat","Can").Can;
    %Int = load("Interviewers.mat","Int").Int;
    save('NextRound.mat', 'Can');
end

