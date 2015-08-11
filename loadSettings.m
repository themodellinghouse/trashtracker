

settings.SScurrentPath        = 'E:\hycom\';
settings.StokesPath           = 'E:\wavewatch3\CFSR\';
settings.WindagePath          = 'E:\gfs\';
settings.StokesBathyFilename  = 'E:\etopo2\ETOPO2_0.5.nc';
settings.GridFilename         = 'E:\grid\HYCOM_grid.nc';
settings.SourceFilename       = 'E:\model\sources_nc\parts_source_1995.nc';
settings.OutputFilename       = 'E:\particles\parts_1995_1995.nc';

settings.initDate       = datenum(1995,01,01,0,0,0);
settings.finalDate      = datenum(1996,01,01,0,0,0);
settings.modelTimestep  = datenum(0,0,0,6,0,0)  *24 *3600 ; %in sec
settings.outputTimestep = datenum(0,0,0,12,0,0);

settings.ForcingCurrent   = true;
settings.ForcingWind      = true;
settings.ForcingWaves     = true;
settings.ForcingDiffusion = true;

settings.WindageCoeff   = 0.01; % windage = 1.5%
settings.EddyDiffusivity= 0.1; % m2/s
settings.TimeAdvectDir    = 1; % =1 normal, -1 reverse dispersal








%% NO EDIT PAST THIS POINT --------------------------------------------------------------------------------------------------------------------

% create time variables
settings.date = settings.initDate;
settings.outputDate = settings.initDate;
settings.outputDateList = (settings.initDate : settings.TimeAdvectDir* settings.outputTimestep : settings.finalDate)' ;

% load grid data
ncid=netcdf.open(settings.GridFilename,'NOWRITE');
    settings.grid.lon = netcdf.getVar(ncid,0);
    settings.grid.lat = netcdf.getVar(ncid,1);
    settings.grid.land= netcdf.getVar(ncid,2);
    settings.grid.dx  = netcdf.getVar(ncid,3);
    settings.grid.dy  = netcdf.getVar(ncid,4);
netcdf.close(ncid)

% get bathymetry for stokes drift calculation (needs to be the same size
% as wave data)
ncid=netcdf.open(settings.StokesBathyFilename,'NOWRITE');
    settings.bathymetry.lon = netcdf.getVar(ncid,0);
    settings.bathymetry.lat = netcdf.getVar(ncid,1);
    settings.bathymetry.d   = netcdf.getVar(ncid,2);
netcdf.close(ncid)






