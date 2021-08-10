MacroTarget = '4h3x-10b'
srcformat='sim'
dstformat='pdb'
waterincluded=0
ForceField AMBER14
central=0
skippedsnapshots=0
if MacroTarget==''
  RaiseError "This macro requires a target. Either edit the macro file or click Options > Macro > Set target to choose a target structure"
if srcformat=='' or dstformat==''
  srcformat,dstformat,waterincluded,skippedsnapshots =
    ShowWin Type=Custom,Title="Select formats to convert trajectory",Width=600,Height=400,
            Widget=Text,        X= 20,Y= 50,Text="Choose the source format (the existing trajectory)",
            Widget=RadioButtons,Options=3,Default=1,
                                X= 20,Y= 70,Text="YASARA _S_im format",
                                X= 20,Y=106,Text="GROMACS _X_TC format",
                                X= 20,Y=142,Text="AMBER _M_DCrd format",
            Widget=Text,        X= 20,Y=188,Text="Choose the destination format (the trajectory to create)",
            Widget=RadioButtons,Options=5,Default=2,
                                X= 20,Y=208,Text="YASARA S_i_m format",
                                X= 20,Y=244,Text="GROMACS X_T_C format",
                                X= 20,Y=280,Text="AMBER M_D_Crd format",
                                X= 20,Y=316,Text="A series of _P_DB files",
                                X= 20,Y=352,Text="_W_rapped PDB files (bonds may cross periodic boundaries)",
            Widget=CheckBox,    X=310,Y=106,Text="_I_nclude water object",Default=Yes,
            Widget=Text,        X=310,Y=228,Text="Skipped snapshots per converted",
            Widget=NumberInput, X=310,Y=248,Text="_s_napshot",Default=0,Min=0,Max=1000,
            Widget=Button,      X=548,Y=348,Text="_O_ K"
  formatlist='sim','xtc','mdcrd','pdb','pdbw'
  srcformat=formatlist(srcformat)
  dstformat=formatlist(dstformat)
if srcformat!='sim' and srcformat!='xtc' and srcformat!='mdcrd'
  RaiseError "The source format must be either 'sim', 'xtc' or 'mdcrd'"
if srcformat==dstformat
  if srcformat=='xtc'
    RaiseError "A conversion from 'xtc' to 'xtc' is not possible"
  elif srcformat=='mdcrd'
    RaiseError "A conversion from 'mdcrd' to 'mdcrd' is not possible"
  elif not central
    RaiseError "A conversion from 'sim' to 'sim' only makes sense if an atom should be kept centered in the cell ('central')"
Cutoff 2.62
Longrange None
LoadSce (MacroTarget)_water
bnd = Boundary
if waterincluded
  selection='Atom all'
else
  selection='Atom all and Obj !Water'
if dstformat=='pdb' or dstformat=='pdbw'
  JoinObj (selection),Atom 1
first=00000
FixAll
old = FileSize (MacroTarget)00000.xtc
if old
  RenameFile (MacroTarget)00000.xtc,(MacroTarget).xtc
for i=0 to 1
  if srcformat=='sim'
    LoadSim (MacroTarget)(first+i)
  else
    Load(srcformat) (MacroTarget),(first+i+1)
  t(i) = Time
steps=0+(t1-t0)
TimeStep 1,1
if dstformat=='xtc' or dstformat=='mdcrd'
  DelFile (MacroTarget).(dstformat)
  Save(dstformat) (MacroTarget),Steps=(steps*(1+skippedsnapshots)),(selection)
elif dstformat=='sim'
  SaveSim (MacroTarget)00000,Steps=(steps*(1+skippedsnapshots))
else
  Sim Pause
Console Off
i=first
do
  if srcformat=='sim'
    LoadSim (MacroTarget)(i)
    found = FileSize (MacroTarget)(i+skippedsnapshots+1).sim
  else
    last = Load(srcformat) (MacroTarget),(i+1)
    found=!last
  t = Time
  ShowMessage 'Converting (srcformat) snapshot (i) from (srcformat) to (dstformat) format, time is (0+t/1000) ps, (steps) fs/snapshot...'
  Time ((0.+i-first)*steps)
  if central
    _,_,_,_,_,_,cen() = Cell
    pos() = PosAtom (central)
    MoveAtom all,(cen-pos)
  if dstformat=='pdb' or dstformat=='pdbw'
    Sim Off
    TransferObj Atom 1,SimCell,Local=Fix
    if dstformat=='pdb'
      Boundary Wall
      _,_,_,_,_,_,cen() = Cell
      Cell (cen*2),90,90,90
    Sim On
    SavePDB Atom 1,(MacroTarget)(i/(1+skippedsnapshots))
    Sim Off
    Boundary (bnd)
    Time (t)
  Wait 1
  if srcformat!='sim'
    j=1
    while found and j<=skippedsnapshots
      last = Load(srcformat) (MacroTarget),(i+j+1)
      found=!last
      j=j+1
  i=i+skippedsnapshots+1
while found    
HideMessage
Sim Off
FreeAll
if runWithMacro and ConsoleMode and !IndentationLevel
  Exit