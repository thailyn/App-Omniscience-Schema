use utf8;
package App::Omniscience::Schema::Result::BoosterVersion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::BoosterVersion

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

=head1 TABLE: C<booster_versions>

=cut

__PACKAGE__->table("booster_versions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'booster_versions_id_seq'

=head2 set_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 card_printing_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 serial

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 number_game_cards

  data_type: 'smallint'
  is_nullable: 0

=head2 number_total_cards

  data_type: 'smallint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "booster_versions_id_seq",
  },
  "set_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "card_printing_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "serial",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "number_game_cards",
  { data_type => "smallint", is_nullable => 0 },
  "number_total_cards",
  { data_type => "smallint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__booster_versions__serial>

=over 4

=item * L</serial>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__booster_versions__serial", ["serial"]);

=head1 RELATIONS

=head2 booster_packs

Type: has_many

Related object: L<App::Omniscience::Schema::Result::BoosterPack>

=cut

__PACKAGE__->has_many(
  "booster_packs",
  "App::Omniscience::Schema::Result::BoosterPack",
  { "foreign.booster_version_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CN/pg70WOm/fTvqLczps3Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
