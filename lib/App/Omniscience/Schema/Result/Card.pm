use utf8;
package App::Omniscience::Schema::Result::Card;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::Card

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

=head1 TABLE: C<cards>

=cut

__PACKAGE__->table("cards");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cards_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 mana_cost

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 converted_mana_cost

  data_type: 'integer'
  is_nullable: 0

=head2 type

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 power

  data_type: 'integer'
  is_nullable: 1

=head2 toughness

  data_type: 'integer'
  is_nullable: 1

=head2 oracle_text

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cards_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "mana_cost",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "converted_mana_cost",
  { data_type => "integer", is_nullable => 0 },
  "type",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "power",
  { data_type => "integer", is_nullable => 1 },
  "toughness",
  { data_type => "integer", is_nullable => 1 },
  "oracle_text",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__cards__name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__cards__name", ["name"]);

=head1 RELATIONS

=head2 card_printings

Type: has_many

Related object: L<App::Omniscience::Schema::Result::CardPrinting>

=cut

__PACKAGE__->has_many(
  "card_printings",
  "App::Omniscience::Schema::Result::CardPrinting",
  { "foreign.card_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 oracle_rulings

Type: has_many

Related object: L<App::Omniscience::Schema::Result::OracleRuling>

=cut

__PACKAGE__->has_many(
  "oracle_rulings",
  "App::Omniscience::Schema::Result::OracleRuling",
  { "foreign.card_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-21 19:46:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:e4BkfhdrX5I5ofiOMiYdOQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
