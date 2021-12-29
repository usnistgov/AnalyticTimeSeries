% Class-based unit testing for AnalyticTS_class
%
%   run these tests with two command-line commands:
%   - testCase = test_AnalyticTS_class;
%   - res = run(testCase);
%   OR
%   - res = testCase.run

classdef test_AnalyticTS_class < matlab.unittest.TestCase
    
    properties
        fig = 1; % figure numbers
        TS
    end
    
    methods (TestClassSetup)
        function constructTS (testCase)
            testCase.TS = AnalyticTS_class;
        end
    end
    
   methods (TestMethodTeardown)
        
   end
    
    methods (Test)
        
        function regressionTests (testCase)
            testCase.TS.Ts.Name = 'testTS';
            disp(testCase.TS.Ts.Name)
            plot(real(testCase.TS.Ts.Data))
        end
    end   
   
end

% We need to write some more regresion tests