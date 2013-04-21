use utf8;
package App::Omniscience::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 password_hash

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 first_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 middle_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 last_name

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 email

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 date_created

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 is_active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "password_hash",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "first_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "middle_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "last_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "email",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "date_created",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "is_active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__users__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__users__name", ["name"]);

=head1 RELATIONS

=head2 booster_packs

Type: has_many

Related object: L<App::Omniscience::Schema::Result::BoosterPack>

=cut

__PACKAGE__->has_many(
  "booster_packs",
  "App::Omniscience::Schema::Result::BoosterPack",
  { "foreign.opener_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 containers

Type: has_many

Related object: L<App::Omniscience::Schema::Result::Container>

=cut

__PACKAGE__->has_many(
  "containers",
  "App::Omniscience::Schema::Result::Container",
  { "foreign.opener_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 personas

Type: has_many

Related object: L<App::Omniscience::Schema::Result::Persona>

=cut

__PACKAGE__->has_many(
  "personas",
  "App::Omniscience::Schema::Result::Persona",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-21 19:46:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tVfr+anelyRows1ba4IPgA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
