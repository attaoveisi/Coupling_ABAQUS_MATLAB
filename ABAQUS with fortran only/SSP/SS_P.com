from driverConstants import *
from driverStandardMPI import StandardMPIAnalysis
import driverUtils, sys
options = {
    'ams':OFF,
    'analysisType':STANDARD,
    'applicationName':'analysis',
    'aqua':OFF,
    'ask_delete':OFF,
    'background':None,
    'beamSectGen':OFF,
    'biorid':OFF,
    'cavityTypes':[],
    'cavparallel':OFF,
    'complexFrequency':OFF,
    'contact':OFF,
    'cosimulation':OFF,
    'coupledProcedure':OFF,
    'cpus':8,
    'cse':OFF,
    'cyclicSymmetryModel':OFF,
    'directCyclic':OFF,
    'direct_port':'55048',
    'direct_solver':DMP,
    'dsa':OFF,
    'dynamic':OFF,
    'enrichment':OFF,
    'filPrt':[],
    'fils':[],
    'finitesliding':OFF,
    'foundation':ON,
    'geostatic':OFF,
    'heatTransfer':OFF,
    'importer':OFF,
    'importerParts':OFF,
    'includes':[],
    'initialConditionsFile':OFF,
    'input':'SS_P',
    'inputFormat':INP,
    'job':'SS_P',
    'keyword_licenses':[],
    'lanczos':OFF,
    'libs':[],
    'listener_name':'ABLAH',
    'listener_resource':'6832',
    'magnetostatic':OFF,
    'massDiffusion':OFF,
    'memory':'90%',
    'message':None,
    'messaging_mechanism':'DIRECT',
    'modifiedTet':OFF,
    'moldflowFiles':[],
    'moldflowMaterial':OFF,
    'mp_file_system':(DETECT, DETECT),
    'mp_head_node':('ablah.mas.ruhr-uni-bochum.de', 'ablah', '134.147.252.5', '192.168.172.1', '192.168.147.1'),
    'mp_host_list':(('ablah', 8),),
    'mp_mode':MPI,
    'mp_mode_requested':MPI,
    'mp_mpi_validate':OFF,
    'mp_mpirun_path':'C:\\Program Files\\Microsoft HPC Pack 2008 R2\\bin\\mpiexec.exe',
    'mp_rsh_command':'dummy %H -l p4wp4w -n %C',
    'mpipre':1,
    'multiphysics':OFF,
    'noDmpDirect':[],
    'noMultiHost':[],
    'noMultiHostElemLoop':[],
    'no_domain_check':1,
    'outputKeywords':ON,
    'parameterized':OFF,
    'partsAndAssemblies':ON,
    'parval':OFF,
    'postOutput':OFF,
    'preDecomposition':ON,
    'restart':OFF,
    'restartEndStep':OFF,
    'restartIncrement':0,
    'restartStep':0,
    'restartWrite':OFF,
    'rezone':OFF,
    'runCalculator':OFF,
    'soils':OFF,
    'soliter':OFF,
    'solverTypes':['DIRECT'],
    'standard_parallel':ALL,
    'staticNonlinear':OFF,
    'steadyStateTransport':OFF,
    'step':ON,
    'subGen':OFF,
    'subGenLibs':[],
    'subGenTypes':[],
    'submodel':OFF,
    'substrLibDefs':OFF,
    'substructure':OFF,
    'symmetricModelGeneration':OFF,
    'thermal':OFF,
    'tmpdir':'C:\\Users\\p4wp4w\\AppData\\Local\\Temp',
    'tracer':OFF,
    'visco':OFF,
}
analysis = StandardMPIAnalysis(options)
status = analysis.run()
sys.exit(status)
