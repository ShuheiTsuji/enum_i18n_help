require 'spec_helper'

class User < ActiveRecord::Base
  include EnumI18nHelp::EnumI18n
  enum sex: { man: 0, woman: 1, nothing: 2 }
end

RSpec.describe EnumI18nHelp::EnumI18n do
  let(:user) { User.create(sex: sex) }
  let(:sex) { 'man' }
  describe '#enum_key_text' do

    subject { user.sex_text }

    context 'lang is ja' do
      before { I18n.locale = :ja }

      it { expect(I18n.locale).to eq :ja }

      context 'sex is man' do
        let(:sex) { 'man' }
        it { is_expected.to eq '男性' }
      end

      context 'sex is woman' do
        let(:sex) { 'woman' }
        it { is_expected.to eq '女性' }
      end

      context 'do not have translated words' do
        let(:sex) { 'nothing' }
        it { is_expected.to eq 'Nothing' }
      end
    end

    context 'lang is en' do
      before { I18n.locale = :en }

      it { expect(I18n.locale).to eq :en }

      context 'sex is man' do
        let(:sex) { 'man' }
        it { is_expected.to eq 'Man' }
      end

      context 'sex is woman' do
        let(:sex) { 'woman' }
        it { is_expected.to eq 'Woman' }
      end

      context 'do not have translated words' do
        let(:sex) { 'nothing' }
        it { is_expected.to eq 'Nothing' }
      end
    end
  end

  describe '#enum_key_options' do
    subject { User.sex_options }

    context 'lang is ja' do
      before { I18n.locale = :ja }

      it { expect(I18n.locale).to eq :ja }
      it { is_expected.to eq [["男性", :man], ["女性", :woman], ["Nothing", :nothing]] }
    end

    context 'lang is en' do
      before { I18n.locale = :en }

      it { expect(I18n.locale).to eq :en }
      it { is_expected.to eq [["Man", :man], ["Woman", :woman], ["Nothing", :nothing]] }
    end
  end
end
