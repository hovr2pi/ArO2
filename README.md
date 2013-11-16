ArO2
====

Ar / O2 potential energy surface
===============================

COLUMBUS has been run on stampede using MCSCF to generate the PES for the Ar + O2 reaction

Convenience scripts for driving columbus for this calculation are avaabile at:
https://github.com/hovr2pi/columbus-stampede.git

The actual script used to this work is located at:
https://github.com/hovr2pi/columbus-stampede/blob/master/local/scripts/control_mcscf.sh

Usage
======

```bash
usage: ./control_mcscf.sh options

This script drives COLUMBUS and interacts with slurm and launcher"

OPTIONS:
-h      Show this message
-n      Number of points (default :1)
-s      Starting point in loop index (default: 0)
-d      Dry run (default OFF)
-v      Verbose / debug on
```

To generate the data, the launcher module was used which is provided by TACC.

To use lauancher you must load the module for it.

```bash
$ module load launcher
```

Now we need the launcher slurm script

```bash
$ cp /opt/apps/launcher/launcher-1.4/launcher.slurm .
```

And we will need to generate our own paramlist file

```bash
$ for i in `seq -w 0 02125`; do echo "./launcher_mcscf.sh -s $i" >> paramlist; done
```

Now we just need to update the launcher.slurm script to use our TACC allocation and run for a bit longer

	
	#SBATCH -J Parametric          # Job name
	#SBATCH -N 1                   # Total number of nodes (16 cores/node)
	#SBATCH -n 16                  # Total number of tasks
	#SBATCH -p normal              # Queue name
	#SBATCH -o Parametric.o%j      # Name of stdout output file (%j expands to jobid)
	#SBATCH -t 04:00:00            # Run time (hh:mm:ss)
	#      <------------ Account String ------------>
	# <--- (Use this ONLY if you have MULTIPLE accounts) --->
	#SBATCH -A A-cmkv11

Finally, we submit the job to the queue.

```bash
$ sbatch launcher.slurm
```

