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

CREATE TABLE billing_document (
    id serial primary key not null,
    event_id_fk integer not null,
    number varchar(255) not null,
    reservation_id_fk character(36) not null,
    type varchar(255) not null,
    model TEXT,
    generation_ts timestamp with time zone not null,
    status varchar(255) not null
);

alter table billing_document add constraint "billing_document_event_id_fk" foreign key(event_id_fk) references event(id);
alter table billing_document add constraint "billing_document_reservation_id_fk" foreign key(reservation_id_fk) references tickets_reservation(id);

