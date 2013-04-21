use utf8;
package App::Omniscience::Schema::Result::BoosterPackCard;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::BoosterPackCard

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

=head1 TABLE: C<booster_pack_cards>

=cut

__PACKAGE__->table("booster_pack_cards");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'booster_pack_cards_id_seq'

=head2 card_printing_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 booster_pack_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'smallint'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 is_foil

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 is_ad

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

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
    sequence          => "booster_pack_cards_id_seq",
  },
  "card_printing_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "booster_pack_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "smallint", is_nullable => 1 },
  "description",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "is_foil",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "is_ad",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
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

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__booster_pack_cards__booster_pack_rank>

=over 4

=item * L</booster_pack_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "unique__booster_pack_cards__booster_pack_rank",
  ["booster_pack_id", "rank"],
);

=head1 RELATIONS

=head2 booster_pack

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::BoosterPack>

=cut

__PACKAGE__->belongs_to(
  "booster_pack",
  "App::Omniscience::Schema::Result::BoosterPack",
  { id => "booster_pack_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 card_printing

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::CardPrinting>

=cut

__PACKAGE__->belongs_to(
  "card_printing",
  "App::Omniscience::Schema::Result::CardPrinting",
  { id => "card_printing_id" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yld36TU20e9qW2B70USi1A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
