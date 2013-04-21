use utf8;
package App::Omniscience::Schema::Result::CardPrinting;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::CardPrinting

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

=head1 TABLE: C<card_printings>

=cut

__PACKAGE__->table("card_printings");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'card_printings_id_seq'

=head2 card_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 set_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rarity_id

  data_type: 'smallint'
  is_foreign_key: 1
  is_nullable: 0

=head2 multiverse_id

  data_type: 'integer'
  is_nullable: 1

=head2 type_text

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 card_text

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 flavor_text

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 card_number

  data_type: 'integer'
  is_nullable: 1

=head2 artist

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "card_printings_id_seq",
  },
  "card_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "set_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "rarity_id",
  { data_type => "smallint", is_foreign_key => 1, is_nullable => 0 },
  "multiverse_id",
  { data_type => "integer", is_nullable => 1 },
  "type_text",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "card_text",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "flavor_text",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "card_number",
  { data_type => "integer", is_nullable => 1 },
  "artist",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__card_printings__card_set>

=over 4

=item * L</card_id>

=item * L</set_id>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__card_printings__card_set", ["card_id", "set_id"]);

=head1 RELATIONS

=head2 artist

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Artist>

=cut

__PACKAGE__->belongs_to(
  "artist",
  "App::Omniscience::Schema::Result::Artist",
  { id => "artist" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 booster_pack_cards

Type: has_many

Related object: L<App::Omniscience::Schema::Result::BoosterPackCard>

=cut

__PACKAGE__->has_many(
  "booster_pack_cards",
  "App::Omniscience::Schema::Result::BoosterPackCard",
  { "foreign.card_printing_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 booster_versions

Type: has_many

Related object: L<App::Omniscience::Schema::Result::BoosterVersion>

=cut

__PACKAGE__->has_many(
  "booster_versions",
  "App::Omniscience::Schema::Result::BoosterVersion",
  { "foreign.card_printing_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 card

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Card>

=cut

__PACKAGE__->belongs_to(
  "card",
  "App::Omniscience::Schema::Result::Card",
  { id => "card_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 rarity

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Rarity>

=cut

__PACKAGE__->belongs_to(
  "rarity",
  "App::Omniscience::Schema::Result::Rarity",
  { id => "rarity_id" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:M9QPkPaiYm1zX5W3BMnaLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
