
select * from [2doPrcial].dbo.Productolocation

select * from [Replica2doParcial].dbo.Productolocation

update [2doPrcial].dbo.Productolocation
set CostRate=4.00 where LocationID=2

declare @contador int,
		@name1 varchar,
		@costoOrig1 int,
		@avalabity1 int,
		@fecha1 date,
		@name2 varchar,
		@costoOrig2 int,
		@avalabity2 int,
		@fecha2 date,
		@sql nvarchar(500)


set @contador=1
while @contador<=60
begin 
	select @name1=Name from [2doPrcial].dbo.Productolocation where LocationID=@contador
	select @name2=Name from Replica2doParcial.dbo.Productolocation where LocationID=@contador
	select @costoOrig1=CostRate from [2doPrcial].dbo.Productolocation where LocationID=@contador
	select @costoOrig2=CostRate from Replica2doParcial.dbo.Productolocation where LocationID=@contador
	select @avalabity1=Availability from [2doPrcial].dbo.Productolocation where LocationID=@contador
	select @avalabity2=Availability from Replica2doParcial.dbo.Productolocation where LocationID=@contador
	if (@costoOrig1<>@costoOrig2)
	begin
		set @sql= 'update [Replica2doParcial].dbo.Productolocation set CostRate=' + cast(@costoOrig1 as varchar(10))+'where LocationID='+ CAST(@contador AS varchar(10)) 
		exec sp_executesql @sql
		print @sql

	end
	set @contador=@contador+1
end