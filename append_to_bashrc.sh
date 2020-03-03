# add some aliases that don't exist by default in this container
alias lla='ll -ah'
alias voms-proxy-init='voms-proxy-init -voms cms --valid 192:00 -cert ~/.globus/usercert.pem -key ~/.globus/userkey.pem'

# Source some CMS/VOMS specific setup scripts
if [ -f "/cvmfs/cms.cern.ch/cmsset_default.sh" ]; then
    source /cvmfs/cms.cern.ch/cmsset_default.sh
else
    echo -e "Unable to source /cvmfs/cms.cern.ch/cmsset_default.sh"
fi
if [ -f "/cvmfs/oasis.opensciencegrid.org/mis/osg-wn-client/current/el6-x86_64/setup.sh" ]; then
    source /cvmfs/oasis.opensciencegrid.org/mis/osg-wn-client/current/el6-x86_64/setup.sh
else
    echo -e "Unable to setup the grid utilities from /cvmfs/oasis.opensciencegrid.org/"
fi

# Needed to access FNAL EOS
export XrdSecGSISRVNAMES="cmseos.fnal.gov"

# CUDA Setup
CUDA_VERSION_SHORT="${CUDA_VERSION%.*}"
export PATH=/usr/local/cuda-${CUDA_VERSION_SHORT}/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA_VERSION_SHORT}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Conda Setup
#. /opt/conda/etc/profile.d/conda.sh
#conda activate base
    
