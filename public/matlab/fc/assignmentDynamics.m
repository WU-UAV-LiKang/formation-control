function assignmentDynamics(block)
  setup(block);

function setup(block)
  %% Register number of dialog parameters   
  block.NumDialogPrms = 0;

  %% Register number of input and output ports
  block.NumInputPorts  = 2;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).Dimensions        = 6^2;
  block.InputPort(1).DirectFeedthrough = false;

  block.InputPort(2).Dimensions        = 6^2;
  block.InputPort(2).DirectFeedthrough = false;

  block.OutputPort(1).Dimensions       = 6^2;
  
  %% Set block sample time to continuous
  block.SampleTimes = [0 0];
  
  %% Setup Dwork
  block.NumContStates = 6^2;

  %% Register methods
  block.RegBlockMethod('InitializeConditions',    @InitConditions);  
  block.RegBlockMethod('Outputs',                 @Output);  
  block.RegBlockMethod('Derivatives',             @Derivative);  

function InitConditions(block)
    block.ContStates.Data = toVector(eye(6));

function Output(block)
    block.OutputPort(1).Data = block.ContStates.Data;

function Derivative(block)
    A1= toMatrix(block.InputPort(1).Data);
    A2= toMatrix(block.InputPort(2).Data);
    P = toMatrix(block.ContStates.Data);        
    k= 1000;
    k= 1000/5 * block.CurrentTime;
    dP = P*(P'*A2*P*A1 -A1*P'*A2*P) -k*P*((P.*P)'*P -P'*(P.*P));
    block.Derivatives.Data = toVector(dP);    
    