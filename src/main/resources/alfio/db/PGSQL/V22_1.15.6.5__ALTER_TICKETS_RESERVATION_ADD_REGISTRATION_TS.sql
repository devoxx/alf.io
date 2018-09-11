--
-- This file is part of alf.io.
--
-- alf.io is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- alf.io is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with alf.io.  If not, see <http://www.gnu.org/licenses/>.
--

alter table tickets_reservation add column registration_ts timestamp with time zone;
alter table tickets_reservation add column fix_billing_document boolean default false;
update tickets_reservation tr set registration_ts = (select to_timestamp(to_char(event_time, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') from auditing where reservation_id = tr.id and event_type = 'RESERVATION_COMPLETE') where id in (select reservation_id from auditing where event_type = 'RESERVATION_COMPLETE');
update tickets_reservation set fix_billing_document = true where registration_ts is not null and date_trunc('day', registration_ts) <> date_trunc('day', creation_ts);

