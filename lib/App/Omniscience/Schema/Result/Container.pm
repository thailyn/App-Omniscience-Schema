use utf8;
package App::Omniscience::Schema::Result::Container;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::Container

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

=head1 TABLE: C<containers>

=cut

__PACKAGE__->table("containers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'containers_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 container_type_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 parent_container_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 number_of_packs

  data_type: 'integer'
  is_nullable: 0

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
    sequence          => "containers_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "container_type_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "parent_container_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "number_of_packs",
  { data_type => "integer", is_nullable => 0 },
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

=head2 booster_packs

Type: has_many

Related object: L<App::Omniscience::Schema::Result::BoosterPack>

=cut

__PACKAGE__->has_many(
  "booster_packs",
  "App::Omniscience::Schema::Result::BoosterPack",
  { "foreign.container_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 container_type

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::ContainerType>

=cut

__PACKAGE__->belongs_to(
  "container_type",
  "App::Omniscience::Schema::Result::ContainerType",
  { id => "container_type_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 containers

Type: has_many

Related object: L<App::Omniscience::Schema::Result::Container>

=cut

__PACKAGE__->has_many(
  "containers",
  "App::Omniscience::Schema::Result::Container",
  { "foreign.parent_container_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 parent_container

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Container>

=cut

__PACKAGE__->belongs_to(
  "parent_container",
  "App::Omniscience::Schema::Result::Container",
  { id => "parent_container_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-21 19:46:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WOQvW4lPqPuI3bSjxstCug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
