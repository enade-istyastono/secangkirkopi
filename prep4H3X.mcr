LoadPDB 4H3X.pdb,Center=No,Correct=No
DelWaterAll
DelMol "B"
DelRes Pgo Gol Ca
DelRes 302
SelectRes "10B"
SplitRes Selected
SplitAll Center=No,Selected,Keep=ObjNum
UnselectAll
pH value=7.4,update=Yes
SavePDB 1,4H3X_rec.pdb,Format=PDB,Transform=No,UseCIF=No
SaveSY2 2,4H3X_lig.mol2,transform=No