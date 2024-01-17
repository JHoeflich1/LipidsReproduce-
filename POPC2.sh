#!/bin/bash
 
#SBATCH --partition=amilan
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --time=24:00:00
#SBATCH --job-name=POPC
#SBATCH --output=POPC.%j.out
 
module purge
source /projects/nasc4134/pkgs/gromacs-2023.1/bin/GMXRC
module load gcc
module load openmpi/4.1.1
 
# Energy minimizaton
#mpirun -np 1 gmx_mpi grompp -p topol.top -f min.mdp -c bilayer.gro -o min.tpr 
#mpirun -np 64 gmx_mpi mdrun -deffnm min

# NVT equilibration (40 ns)
#mpirun -np 1 gmx_mpi grompp -p topol.top -f nvt.mdp -c min.gro -o nvt.tpr
#mpirun -np 64 gmx_mpi mdrun -deffnm nvt

# NPT equilibration (60 ns)
#mpirun -np 1 gmx_mpi grompp -p topol.top -f npt.mdp -c nvt.gro -o npt.tpr
#mpirun -np 64 gmx_mpi mdrun -deffnm npt
#mpirun -np 64 gmx_mpi mdrun -deffnm npt -cpi npt.cpt

# Production MD
#mpirun -np 1 gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
#mpirun -np 64 gmx_mpi mdrun -deffnm md
mpirun -np 64 gmx_mpi mdrun -deffnm md -cpi md.cpt~                
