require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post model' do
    user = User.create(name: 'Blessed J. Mwanza', bio: 'bio template')
    subject do
      Post.new(title: 'My new post', text: 'Hi there robot :-) ', author: user)
    end
    before { subject.save }

    it 'check if the title is not empty' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'check if the title is not exceeding 250 characters' do
      subject.title = 'Kasd duo diam invidunt diam clita elitr gubergren. Sanctus sed dolores et duo. Sit clita sadipscing amet et dolor at lorem, sit tempor magna lorem invidunt invidunt accusam consetetur amet aliquyam, justo sanctus sanctus diam at accusam stet eos at, dolores ipsum sed ut sea sed duo et, aliquyam dolore sed kasd ipsum lorem lorem ipsum clita. Rebum et labore dolores lorem et sadipscing no accusam, dolor et elitr sea ea aliquyam et lorem accusam sea. Est duo accusam sanctus gubergren est sea. Diam sadipscing eos sadipscing eirmod ipsum nonumy rebum. Sea stet sit dolor sed, dolore accusam sed dolor no, at sanctus dolor elitr sanctus et sadipscing lorem nonumy. Erat takimata sit duo et, accusam sea takimata dolor sit ut ipsum justo et invidunt, dolore diam vero eos dolore rebum. Amet sadipscing dolor rebum ipsum erat. Dolor clita stet invidunt lorem amet dolore clita, ea diam clita dolor dolore aliquyam clita magna dolor, et sit stet magna ipsum lorem sadipscing sed dolor diam. Diam stet eirmod voluptua no ea magna accusam. Aliquyam ut et labore stet vero sed dolore eirmod labore. Invidunt nonumy eos eirmod lorem ut, et ipsum justo vero dolore consetetur no. Nonumy justo dolore sanctus tempor kasd accusam consetetur amet dolor. Et nonumy takimata sea diam ut ipsum voluptua. Sanctus dolor clita nonumy justo sit eos eos dolores gubergren, vero diam justo et labore, no lorem consetetur accusam ut sanctus consetetur tempor ipsum ea, dolor kasd sadipscing vero sit accusam diam ipsum aliquyam est, nonumy dolore lorem et elitr aliquyam diam, sanctus gubergren dolor rebum ut gubergren. Takimata magna et accusam erat et ea. Tempor at lorem amet tempor sed dolor amet. Elitr invidunt gubergren lorem ipsum justo sadipscing aliquyam. Dolores et consetetur ut sed sed magna et, diam vero nonumy diam eos ea et erat, dolor ut ut sed est diam at. Nonumy amet est diam stet at, sadipscing sea elitr accusam nonumy stet sed et, dolor eos ea magna gubergren sanctus et ipsum, lorem.'
      expect(subject).to_not be_valid
    end

    it 'validates that likes counter is >= to 0. ' do
      subject.Likes_Counter = -1
      expect(subject).to_not be_valid
    end

    it 'loads only the most recent 5 comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end
  end
end