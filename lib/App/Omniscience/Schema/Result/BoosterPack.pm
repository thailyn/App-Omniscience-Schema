use utf8;
package App::Omniscience::Schema::Result::BoosterPack;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::BoosterPack

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<booster_packs>

=cut

__PACKAGE__->table("booster_packs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'booster_packs_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 set_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 booster_version_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 code

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 container_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 container_column

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 container_rank

  data_type: 'integer'
  is_nullable: 1

=head2 price

  data_type: 'numeric'
  is_nullable: 1
  size: [10,3]

=head2 source

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 opener_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 open_date

  data_type: 'date'
  is_nullable: 1

=head2 persona_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 modified

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "booster_packs_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "set_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "booster_version_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "code",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "container_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "container_column",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "container_rank",
  { data_type => "integer", is_nullable => 1 },
  "price",
  { data_type => "numeric", is_nullable => 1, size => [10, 3] },
  "source",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "opener_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "open_date",
  { data_type => "date", is_nullable => 1 },
  "persona_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "modified",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 booster_pack_cards

Type: has_many

Related object: L<App::Omniscience::Schema::Result::BoosterPackCard>

=cut

__PACKAGE__->has_many(
  "booster_pack_cards",
  "App::Omniscience::Schema::Result::BoosterPackCard",
  { "foreign.booster_pack_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 booster_version

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::BoosterVersion>

=cut

__PACKAGE__->belongs_to(
  "booster_version",
  "App::Omniscience::Schema::Result::BoosterVersion",
  { id => "booster_version_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 container

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Container>

=cut

__PACKAGE__->belongs_to(
  "container",
  "App::Omniscience::Schema::Result::Container",
  { id => "container_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 opener

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "opener",
  "App::Omniscience::Schema::Result::User",
  { id => "opener_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 persona

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Persona>

=cut

__PACKAGE__->belongs_to(
  "persona",
  "App::Omniscience::Schema::Result::Persona",
  { id => "persona_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 set

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Set>

=cut

__PACKAGE__->belongs_to(
  "set",
  "App::Omniscience::Schema::Result::Set",
  { id => "set_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-21 19:46:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5agfUQY9BKRUtS+AbnccLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
