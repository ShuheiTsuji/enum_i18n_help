require 'spec_helper'

class User < ActiveRecord::Base
  include EnumI18nHelp::EnumI18n
  enum sex: { man: 0, woman: 1, nothing: 2 }
  enum job: %i[engineer designer journalist]
end

class Article < ActiveRecord::Base
  include EnumI18nHelp::EnumI18n
  enum status: %i[draft published archived deleted]
end

RSpec.describe EnumI18nHelp::EnumI18n do
  describe '#enum' do
    context 'With hash definitions' do
      it 'responds defined text method' do
        expect(User.new).to respond_to("sex_text")
      end

      it 'responds defined options method' do
        expect(User).to respond_to("sex_options")
      end
    end

    context 'With array definitions' do
      it 'responds defined text method' do
        expect(Article.new).to respond_to("status_text")
      end

      it 'responds defined options method' do
        expect(Article).to respond_to("status_options")
      end
    end
  end

  describe '#enum_key_text' do
    describe 'user.sex' do
      let(:user) { User.create(sex: sex) }
      let(:sex) { 'man' }

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

    describe 'user.job' do
      let(:user) { User.create(sex: 'man', job: job) }

      subject { user.job_text }

      context 'lang is ja' do
        before { I18n.locale = :ja }

        it { expect(I18n.locale).to eq :ja }

        context 'job is engineer' do
          let(:job) { 'engineer' }
          it { is_expected.to eq 'エンジニア' }
        end

        context 'job is nil' do
          let(:job) { nil }
          it { is_expected.to eq nil }
        end
      end

      context 'lang is en' do
        before { I18n.locale = :en }

        it { expect(I18n.locale).to eq :en }

        context 'job is engineer' do
          let(:job) { 'engineer' }
          it { is_expected.to eq 'Engineer' }
        end

        context 'job is nil' do
          let(:job) { nil }
          it { is_expected.to eq nil }
        end
      end
    end
  end

  describe '#enum_key_options' do
    subject { User.sex_options }

    context 'lang is ja' do
      before { I18n.locale = :ja }

      it { expect(I18n.locale).to eq :ja }
      it { is_expected.to eq [["男性", :man], ["女性", :woman], ["Nothing", :nothing]] }
      it { is_expected.not_to include ['ghost_enum_key', 'User modelのenum定義に存在しないキー'] }
    end

    context 'lang is en' do
      before { I18n.locale = :en }

      it { expect(I18n.locale).to eq :en }
      it { is_expected.to eq [["Man", :man], ["Woman", :woman], ["Nothing", :nothing]] }
      it { is_expected.not_to include ['ghost_enum_key', 'This key does not exist in User model\'s enum definition'] }
    end
  end
end
