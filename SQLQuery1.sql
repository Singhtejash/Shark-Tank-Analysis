select * from Port_project..pitches

--total episodes=35
select  max(epno) from Port_project..pitches

--number of pitches=117
Select count(distinct idea) from Port_project..pitches

--companies got funding= 64 i.e, 54.7%
select cast(sum(a.converted) as float) /cast(count(*) as float) from (
select Amountinvestedlakhs, case when amountinvestedlakhs>0 then 1 else 0 end as converted from Port_project..pitches) a

--total male participants=165
select sum(Male) from Port_project..pitches

--total female participants=73
select sum(Female) from Port_project..Pitches

--percenage female participants= 44.24%
Select sum(Female)/sum(male) from Port_project..Pitches

--total amount invested(in lakhs)=3827
select sum(Amountinvestedlakhs) from Port_project..Pitches

--Avg equity take by shark= 16.324375
select avg(a.Equitytaken) from
(select * from Port_project..Pitches where Equitytaken>0)a

--biggest deal(inlakhs)=150
select max(Amountinvestedlakhs) from Port_project..Pitches

--highest equity taken by shark= 75%
select max(Equitytaken) from Port_project..Pitches

--Pitches having female number=63
select sum(a.female_count) from(
select female, case when female>0 then 1 else 0 end as female_count from Port_project..pitches) a

--pitches converted having atleast one female=30
select sum(b.female_converted) from
(select case when a.female>0 then 1 else 0 end as female_converted, a.*from(
select * from Port_project..pitches where Deal!='No Deal')a)b

--Average team members in pitches= 2.086
select avg(Teammembers) from Port_project..pitches

--amount invested per deal= 59.55
select avg(a.Amountinvestedlakhs) from(
select * from Port_project..Pitches where Deal!= 'No Deal')a

--avg age group of pitchers= 37 pitches in 30-35 age group 
select Avgage, count(Avgage) cnt from Port_project..Pitches group by Avgage order by cnt desc

--Location from where max pitches belong= Mumbai(22)
select Location, count(Location) cnt from Port_project..Pitches group by Location order by cnt desc

--sector to which max pitches belong= Food(37)
select Sector, count(Sector) cnt from Port_project..Pitches group by Sector order by cnt desc

--making of matrix

-- Pitches in which Ashneer is present=(98)
select count(Ashneeramountinvested) from Port_project..Pitches where Ashneeramountinvested is not Null 
--Ashneer investments=21
select count(Ashneeramountinvested) from Port_project..Pitches where Ashneeramountinvested is not Null and Ashneeramountinvested!=0
--total invetsment made by ashneer= 650.83 and avg equity taken=4.34
select sum(a.Ashneeramountinvested), avg(a.AshneerEquityTaken) from
(select * from Port_project..Pitches where Ashneeramountinvested!=0 and Ashneeramountinvested is not null) a

select m.keyy, m.total_deal_present, m.deals_converted, n.total_amount_invested, n.equity_taken from(
(select a.keyy, a.total_deal_present, b.deals_converted from(
select 'Ashneer' as keyy, count(Ashneeramountinvested) total_deal_present from Port_project..Pitches where Ashneeramountinvested is not Null) a

inner join(

select 'Ashneer' as keyy, count(Ashneeramountinvested) deals_converted from Port_project..Pitches where Ashneeramountinvested is not Null and Ashneeramountinvested!=0)b
on  a.keyy=b.keyy)m

inner join (

select 'Ashneer' as keyy,  sum(c.Ashneeramountinvested) total_amount_invested, avg(c.AshneerEquityTaken) equity_taken from
(select * from Port_project..Pitches where Ashneeramountinvested!=0 and Ashneeramountinvested is not null) c)n
on  m.keyy=n.keyy
