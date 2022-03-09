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
            %testCase.TS.Ts.Name = 'testTS';
            %disp(testCase.TS.Ts.Name)
            %plot(real(testCase.TS.Ts.Data))
            %testCase = testPhaseStep(testCase);
            %testCase = testMagDropAndRestore(testCase);
            testCase = testBandLimitedNoise(testCase);
        end
    end  
    
    methods 
        
        function testCase = testPhaseStep (testCase)
            testCase.TS.SettlingTime = 1.0;
            testCase.TS.T0 = 0.5;
            testCase.TS.Duration = 3;
            [~,Fin,~,~,~,~,~,~,~,~,~,KaS,KxS]  = testCase.TS.getParamIndex;
            testCase.TS.SignalParams(KxS,:) = .1;
            testCase.TS = testCase.TS.AnalyticWaveforms();
            plot(real(testCase.TS.Ts.Data))
            hold on
            testCase.TS.SettlingTime = 1.0 - .1/testCase.TS.SignalParams(Fin,1);
            testCase.TS = testCase.TS.AnalyticWaveforms();
            plot(real(testCase.TS.Ts.Data))
            hold off
            
        end
        
        function testCase = testMagDropAndRestore (testCase)
            % A special test for frequency calibration, when magnitude drops to 0, the frequency returns to a different value
            testCase.TS.SettlingTime = 1.0;
            testCase.TS.T0 = 0.5;
            testCase.TS.Duration = 3;
            [~,~,~,~,~,~,~,~,~,~,~,~,KxS,KfS]  = testCase.TS.getParamIndex;
            testCase.TS.SignalParams(KxS,:) = -1;
            testCase.TS.SignalParams(KfS,:) = 50;
            testCase.TS = testCase.TS.AnalyticWaveforms();
            plot(real(testCase.TS.Ts.Data))
        end
        
        function testCase = testBandLimitedNoise (testCase)
            testCase.TS = AnalyticTS_class; 
            testCase.TS.Duration = 2;
            testCase.TS.SettlingTime = 1;
            [~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,Kn,Fn]   = testCase.TS.getParamIndex;
            testCase.TS.SignalParams(Kn,:) = 0.03;
            testCase.TS.SignalParams(Fn,:) = 2000;
            testCase.TS = testCase.TS.AnalyticWaveforms();
            plot(testCase.TS.Ts.Time,real(testCase.TS.Ts.Data))
        end
        
    end
   
end

% We need to write some more regresion tests
